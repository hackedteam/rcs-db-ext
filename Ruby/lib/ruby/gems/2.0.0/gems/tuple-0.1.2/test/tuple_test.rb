require File.dirname(__FILE__) + '/test_helper'

class Time
  def ==(other)
    # Ignore microseconds for testing.
    to_i == other.to_i
  end
end

class TupleTest < Test::Unit::TestCase
  should "dump and load arrays of simple types" do
    t = [1, true, :foo, "foo", -1001, false, nil, Time.now, Date.today - 7, [:foo, 1, 4, nil]]
    assert_equal t, Tuple.load(Tuple.dump(t))
  end
  
  should "dump, load, and sort fixnums and bignums" do
    t = [2**64, 2**38, 2**32, 2**32 - 1, 2**31, 2**31 - 1, 1, 0]
    t = t + t.reverse.collect {|n| -n}
    assert_equal t, Tuple.load(Tuple.dump(t))
    assert_equal t.reverse, t.sort_by {|i| Tuple.dump(i)}
  end

  should "convert single value into array" do
    assert_equal [1], Tuple.load(Tuple.dump(1))
  end

  should "dump times consistently" do
    t = '2009-10-15 1:23:45 PM'
    tuple = Tuple.dump(Time.parse(t))
    100000.times do
      assert_equal tuple, Tuple.dump(Time.parse(t))
    end
  end

  should "sort tuples using binary" do
    now   = Time.now.getgm
    today = Date.parse(now.to_s)

    tuples = [
      [1, "foo"],
      [1, true],
      [2],
      [1],
      [nil],
      [true],
      [:foo, -1],
      [:foo, -2**64],
      [:foo,  2**64],
      [1, "foo", 7, nil, false, true],
      [1, "foo", 7, nil, false, false],
      ["charles", "atlas"],
      ["charles", "atlas", "shrugged"],
      ["charles", "atlantic"],
      ["charles", "atlas jr."],
      ["charles", "atlas", "world's", "strongest", "man"],
      ["charles", "atlas", 5],
      [now, "foo"],
      [now, "bar"],
      [now - 24 * 60 * 60],
      [today + 1],
      [today - 1],
      [today],
    ]

    expected = [
      [nil],
      [1],
      [1, "foo"],
      [1, "foo", 7, nil, false, false],
      [1, "foo", 7, nil, false, true],
      [1, true],
      [2],
      ["charles", "atlantic"],
      ["charles", "atlas"],
      ["charles", "atlas", 5],
      ["charles", "atlas", "shrugged"],
      ["charles", "atlas", "world's", "strongest", "man"],
      ["charles", "atlas jr."],
      [:foo, -18446744073709551616],
      [:foo, -1],
      [:foo, 18446744073709551616],
      [today - 1],
      [now - 24 * 60 * 60],
      [today],
      [now, "bar"],
      [now, "foo"],
      [today + 1],
      [true]
    ]
    assert_equal expected, tuples.sort_by {|t| Tuple.dump(t)}

    100.times do
      assert_equal expected, tuples.shuffle.sort_by {|t| Tuple.dump(t)}
    end
  end 
end
