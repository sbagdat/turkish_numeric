# TurkishNumeric [![Gem Version](https://badge.fury.io/rb/turkish_numeric.svg)](https://badge.fury.io/rb/turkish_numeric)   [![Build Status](https://travis-ci.com/sbagdat/turkish_numeric.svg?branch=main)](https://travis-ci.com/sbagdat/turkish_numeric)  [![Code Climate](https://codeclimate.com/github/sbagdat/turkish_numeric/badges/gpa.svg)](https://codeclimate.com/github/sbagdat/turkish_numeric) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Translate any numeric value into Turkish text, currency notation and text representation of money.

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

First, you should require the gem (if you are using rails you don't need to require).

```ruby
require 'turkish_numeric'
```

If you like shorter code lines you can include the module and can use `TrNum(numeric_value)` utility method. 
Otherwise you should use `TurkishNumeric::TrNum.new(numeric_value)` or `TurkishNumeric.TrNum(numeric_value)`.
At the examples below, shorter version is used.

```ruby
include TurkishNumeric
```

### Translating integer numbers

```ruby
TrNum(0).to_text          # => "sıfır"
TrNum(34_430_002).to_text # => "otuz dört milyon dört yüz otuz bin iki"
TrNum(-999999).to_text    # => "eksi dokuz yüz doksan dokuz bin dokuz yüz doksan dokuz"
```

You can translate any integer value from **-999 * 10<sup>63</sup>** to **999 * 10<sup>63</sup>**.

```ruby
TrNum(999_000_000_999_000_000_000_000_000_000_000_000_000_000_009_900_000_000_000_000_000_000).to_text
# => "dokuz yüz doksan dokuz vigintilyon dokuz yüz doksan dokuz septendesilyon dokuz sekstilyon dokuz yüz kentilyon"
```

### Translating floating point numbers

```ruby
TrNum(1234.00001).to_text    # => "bin iki yüz otuz dört tam yüz binde bir"
TrNum(34_430_002.45).to_text # => "otuz dört milyon dört yüz otuz bin iki yüzde kırk beş"
TrNum(12.00120012).to_text   # => "on iki tam yüz milyonda yüz yirmi bin on iki"
TrNum(0.9999999999999999).to_text 
# => "sıfır tam on katrilyonda dokuz katrilyon dokuz yüz doksan dokuz trilyon dokuz yüz doksan dokuz
#     milyar dokuz yüz doksan dokuz milyon dokuz yüz doksan dokuz bin dokuz yüz doksan dokuz"
```

### Translating as money

```ruby
TrNum(12.34).to_money    # => "₺12,34"
TrNum(120.34).to_money   # => "₺120,34"
TrNum(343_211_122_332.45).to_money   # => "₺343.211.122.332,45"
```

Custom currency symbol, thousand seperator, and penny seperator are also supported.

```ruby
TrNum(12_332.45).to_money(symbol: '€', 
                          thousand_sep: ',', 
                          penny_sep: '.') 
# => "€12,332.45"
```

### Translating as money text 

```ruby
TrNum(234.05).to_money_text       # => "ikiyüzotuzdörtTL,beşkr"
TrNum(600_000.125).to_money_text  # => "altıyüzbinTL,onikikr"
```

Custom currency and sub currency are also supported.
```ruby
TrNum(234.45).to_money_text(currency: 'USD', sub_currency: 'sent')
# => 'ikiyüzotuzdörtUSD,kırkbeşsent'
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sbagdat/turkish_numeric. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/sbagdat/turkish_numeric/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the TurkishNumeric project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/sbagdat/turkish_numeric/blob/main/CODE_OF_CONDUCT.md).
