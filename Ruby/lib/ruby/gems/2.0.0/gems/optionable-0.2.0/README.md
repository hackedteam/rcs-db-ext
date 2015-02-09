BSON [![Build Status](https://secure.travis-ci.org/durran/optionable.png?branch=master&.png)](http://travis-ci.org/durran/optionable) [![Code Climate](https://codeclimate.com/github/durran/optionable.png)](https://codeclimate.com/github/durran/optionable) [![Coverage Status](https://coveralls.io/repos/durran/optionable/badge.png?branch=master)](https://coveralls.io/r/durran/optionable?branch=master)
====

Robust validation of options passed to Ruby methods.

Compatibility
-------------

BSON is tested against MRI (1.9.2+), JRuby (1.7.0+), Rubinius (2.0.0+).

Installation
------------

With bundler, add the `optionable` gem to your `Gemfile`.

```ruby
gem "optionable",
```

Require the `optionable` gem in your application.

```ruby
require "optionable"
```

Usage
-----

Include the optional module in your object, and use the DSL for define what values
are valid for the specified options. Currently you can match on exact values or
values of a specific type. Then to validate your options, simply call `validate_strict`
and pass it the hash of options.

```ruby
class Parser
  include Optionable

  option(:streaming).allow(true, false)
  option(:timeout).allow(Optionable.any(Integer))

  def initialize(options = {})
    validate_strict(options)
  end
end
```

If the options are invalid, an `Optionable::Invalid` error will be raised.

If an unknown option is provided, an `Optionable::Unknown` error will be
raised.

API Documentation
-----------------

The [API Documentation](http://rdoc.info/github/durran/optionable/master/frames) is
located at rdoc.info.

Versioning
----------

This project adheres to the [Semantic Versioning Specification](http://semver.org/).

License
-------

Copyright (c) 2013 Durran Jordan

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
