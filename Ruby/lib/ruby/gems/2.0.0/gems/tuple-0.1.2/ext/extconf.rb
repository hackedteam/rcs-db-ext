require 'mkmf'

case RUBY_VERSION
when /\A1\.8/
  $CFLAGS += ' -DRUBY_1_8_x'
when /\A1\.9/
  $CFLAGS += ' -DRUBY_1_9_x'
when /\A2\.0/
  $CFLAGS += ' -DRUBY_1_9_x'
else
  raise "unsupported Ruby version: #{RUBY_VERSION}"
end

create_makefile('tuple')
