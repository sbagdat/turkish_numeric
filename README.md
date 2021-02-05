# TurkishNumeric

[![Gem Version](https://badge.fury.io/rb/turkish_numeric.svg)](https://badge.fury.io/rb/turkish_numeric)
[![Build Status](https://travis-ci.com/sbagdat/turkish_numeric.svg?branch=main)](https://travis-ci.com/sbagdat/turkish_numeric)
[![Code Climate](https://codeclimate.com/github/sbagdat/turkish_numeric/badges/gpa.svg)](https://codeclimate.com/github/sbagdat/turkish_numeric)
[![Coverage Status](https://coveralls.io/repos/github/sbagdat/turkish_numeric/badge.svg?branch=main)](https://coveralls.io/github/sbagdat/turkish_numeric?branch=main)

Translate any numeric value into Turkish text.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'turkish_numeric'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install turkish_numeric

## Usage

After the installation of the gem, you can use it as shown below:

```ruby
require 'turkish_numeric'

include TurkishNumeric

# Translating integers
TrNum(34_430_002).to_text # => "otuz dört milyon dört yüz otuz bin iki"

# Translating floats
TrNum(1234.00001).to_text # => "bin iki yüz otuz dört tam yüz binde bir"
```

For more examples look at teh test files [here](spec/tr_num_spec.rb)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sbagdat/turkish_numeric. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/sbagdat/turkish_numeric/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the TurkishNumeric project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/sbagdat/turkish_numeric/blob/main/CODE_OF_CONDUCT.md).
