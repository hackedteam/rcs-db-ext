#include "ruby.h"
#include <netinet/in.h>

VALUE mTuple;
VALUE rb_cDate;

#define TRUE_SORT  255 // TrueClass
#define TUPLE_SORT 192 // Array
#define TUPLE_END  191 // For nested tuples 
#define TIME_SORT  128 // Time
#define SYM_SORT    64 // Symbol
#define STR_SORT    32 // String
#define INTP_SORT   16 // Integer (Positive)
#define INTN_SORT    8 // Integer (Negative)
#define FALSE_SORT   1 // FalseClass
#define NIL_SORT     0 // NilClass

#define BDIGITS(x) ((BDIGIT*)RBIGNUM(x)->digits)

static void null_pad(VALUE data, int len) {
  static u_int8_t null = 0;

  // Pad with null bytes so subsequent fields will be aligned.
  while (len % 4 != 0) {
    rb_str_cat(data, (char*)&null, 1);
    len++;
  }
}


u_int32_t split64(int64_t num, int word) {
  u_int32_t *split = (u_int32_t*)(void*)&num;

  static int i = 1;
  if (*(char *)&i == 1) word = word ? 1: 0;
  else                  word = word ? 0: 1;

  return split[word];
}



/*
 * call-seq:
 * Tuple.dump(tuple) -> string
 *
 * Dumps an array of simple Ruby types into a string of binary data.
 *
 */
static VALUE tuple_dump(VALUE self, VALUE tuple) {
  VALUE data = rb_str_new2("");
  VALUE item;
  int i, j, len, sign;
  u_int8_t header[4];
  u_int32_t digit;
  int64_t fixnum;
  BDIGIT *digits;


  if (TYPE(tuple) != T_ARRAY) tuple = rb_ary_new4(1, &tuple);

#if defined(RUBY_1_9_x)
  for (i = 0; i < RARRAY_LEN(tuple); i++) {
      item = RARRAY_PTR(tuple)[i];
#elif defined(RUBY_1_8_x)
    for (i = 0; i < RARRAY(tuple)->len; i++) {
        item = RARRAY(tuple)->ptr[i];
#else
#error unsupported RUBY_VERSION
#endif
    header[0] = header[1] = header[2] = header[3] = 0;
    if (FIXNUM_P(item)) {
      fixnum = FIX2LONG(item);
      sign = (fixnum >= 0);
      if (!sign) fixnum = -fixnum;
      len = fixnum > UINT_MAX ? 2 : 1;
      header[2] = sign ? INTP_SORT : INTN_SORT;
      header[3] = sign ? len : UCHAR_MAX - len;
      rb_str_cat(data, (char*)&header, sizeof(header));      

      if (len == 2) {
        digit = split64(fixnum, 1);
        digit = htonl(sign ? digit : UINT_MAX - digit);
        rb_str_cat(data, (char*)&digit, sizeof(digit));
      }
      digit = split64(fixnum, 0);
      digit = htonl(sign ? digit : UINT_MAX - digit);
      rb_str_cat(data, (char*)&digit, sizeof(digit));
    } else if (TYPE(item) == T_BIGNUM) {
#if defined(RUBY_1_9_x)
      sign = RBIGNUM_SIGN(item);
      len  = RBIGNUM_LEN(item);
#elif defined(RUBY_1_8_x)
      sign = RBIGNUM(item)->sign;
      len  = RBIGNUM(item)->len;
#else
#error unsupported RUBY_VERSION
#endif
      header[2] = sign ? INTP_SORT : INTN_SORT;
      header[3] = sign ? len : UCHAR_MAX - len;
      rb_str_cat(data, (char*)&header, sizeof(header));

#if defined(RUBY_1_9_x)
      digits = RBIGNUM_DIGITS(item);
#elif defined(RUBY_1_8_x)
      digits = BDIGITS(item);
#else
#error unsupported RUBY_VERSION
#endif
      for (j = len-1; j >= 0; j--) {
        digit = htonl(sign ? digits[j] : (UINT_MAX - digits[j]));
        rb_str_cat(data, (char*)&digit, sizeof(digit));
      }
    } else if (SYMBOL_P(item) || TYPE(item) == T_STRING) {
      if (SYMBOL_P(item)) {
        header[2] = SYM_SORT;
        item = rb_funcall(item, rb_intern("to_s"), 0);
      } else {
        header[2] = STR_SORT;
      }
      rb_str_cat(data, (char*)&header, sizeof(header));
      len = RSTRING_LEN(item);
      rb_str_cat(data, RSTRING_PTR(item), len);
      
      null_pad(data, len);
    } else if (rb_obj_class(item) == rb_cTime || rb_obj_class(item) == rb_cDate) {
      header[2] = TIME_SORT;
      rb_str_cat(data, (char*)&header, sizeof(header));

      if (rb_obj_class(item) == rb_cTime) {
        item = rb_funcall(item, rb_intern("getgm"), 0);
        item = rb_funcall(item, rb_intern("strftime"), 1, rb_str_new2("%Y/%m/%d %H:%M:%S +0000"));
      } else {
        item = rb_funcall(item, rb_intern("strftime"), 1, rb_str_new2("%Y/%m/%d"));
      }
      len = RSTRING_LEN(item);
      rb_str_cat(data, RSTRING_PTR(item), len);

      null_pad(data, len);
    } else if (TYPE(item) == T_ARRAY) {
      header[2] = TUPLE_SORT;
      rb_str_cat(data, (char*)&header, sizeof(header));

      rb_str_concat(data, tuple_dump(mTuple, item));

      header[2] = TUPLE_END;
      rb_str_cat(data, (char*)&header, sizeof(header));      
    } else {        
      if      (item == Qnil)   header[2] = NIL_SORT;
      else if (item == Qtrue)  header[2] = TRUE_SORT;
      else if (item == Qfalse) header[2] = FALSE_SORT;
      else    rb_raise(rb_eTypeError, "invalid type %s in tuple", rb_obj_classname(item));
      
      rb_str_cat(data, (char*)&header, sizeof(header));      
    }
  }
  return data;
}

static VALUE empty_bignum(int sign, int len) {
#if defined(RUBY_1_9_x)
  return rb_big_new(len, sign);
#elif defined(RUBY_1_8_x)
  /* Create an empty bignum with the right number of digits. */
  NEWOBJ(num, struct RBignum);
  OBJSETUP(num, rb_cBignum, T_BIGNUM);

  num->sign = sign ? 1 : 0;
  num->len = len;
  num->digits = ALLOC_N(BDIGIT, len);

  return (VALUE)num;
#else
#error unsupported RUBY_VERSION
#endif
}

static VALUE tuple_parse(void **data, int data_len) {
  VALUE tuple = rb_ary_new();
  VALUE item;
  void* ptr = *data; *data = &ptr;
  void* end = ptr + data_len;
  int i, len, sign;
  u_int8_t header[4];
  u_int32_t digit;
  BDIGIT *digits;

  while (ptr < end) {
    memcpy(header, ptr, 4);
    ptr += 4;

    switch(header[2]) {
    case TRUE_SORT:  rb_ary_push(tuple, Qtrue);  break;
    case FALSE_SORT: rb_ary_push(tuple, Qfalse); break;
    case NIL_SORT:   rb_ary_push(tuple, Qnil);   break;
    case INTP_SORT:
    case INTN_SORT:
      sign  = (header[2] == INTP_SORT);
      len   = sign ? header[3] : (UCHAR_MAX - header[3]);

      item = empty_bignum(sign, len);
#if defined(RUBY_1_9_x)
      digits = RBIGNUM_DIGITS(item);
#elif defined(RUBY_1_8_x)
      digits = BDIGITS(item);
#else
#error unsupported RUBY_VERSION
#endif
      for (i = len-1; i >= 0; i--) {
        digit = ntohl(*(u_int32_t*)ptr);
        digits[i] = sign ? digit : UINT_MAX - digit;
        ptr += 4;
      }
      rb_ary_push(tuple, item);
      break;
    case STR_SORT:
    case SYM_SORT:
      item = rb_str_new2(ptr);
      len  = RSTRING_LEN(item);
      if (header[2] == SYM_SORT) item = rb_funcall(item, rb_intern("to_sym"), 0);
      rb_ary_push(tuple, item);
      while (len % 4 != 0) len++; ptr += len;
      break;
    case TIME_SORT:
      item = rb_str_new2(ptr);
      len  = RSTRING_LEN(item);
      if (len == 10) item = rb_funcall(rb_cDate, rb_intern("parse"), 1, item);
      else           item = rb_funcall(rb_cTime, rb_intern("parse"), 1, item);
      rb_ary_push(tuple, item);
      while (len % 4 != 0) len++; ptr += len;
      break;
    case TUPLE_SORT:
      item = tuple_parse(&ptr, end - ptr);
      rb_ary_push(tuple, item);
      break;
    case TUPLE_END:
      return tuple;
    default:
      rb_raise(rb_eTypeError, "invalid type code %d in tuple", header[2]);
      break;
    }
  }
  return tuple;
}

/*
 * call-seq:
 * Tuple.load(string) -> tuple
 *
 * Reads in a previously dumped tuple from a string of binary data.
 *
 */
static VALUE tuple_load(VALUE self, VALUE data) {
  data = StringValue(data);
  void* ptr = RSTRING_PTR(data);
  return tuple_parse(&ptr, RSTRING_LEN(data));
}

VALUE mTuple;
void Init_tuple() {
  rb_require("time");
  rb_require("date");
  rb_cDate = rb_const_get(rb_cObject, rb_intern("Date"));

  mTuple = rb_define_module("Tuple");
  rb_define_module_function(mTuple, "dump", tuple_dump, 1);
  rb_define_module_function(mTuple, "load", tuple_load, 1);
}
