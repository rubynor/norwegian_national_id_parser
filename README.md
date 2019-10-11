# Norwegian national id parser

A simple way to valdiate and get information like date of birth and gender from a norwegian national id number.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'norwegian_national_id_parser'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install norwegian_national_id_parser

## Usage

```Ruby
national_id = NorwegianNationalIdParser.parse("13042046846")

# Get date of birth
national_id.birth_date
# => 1920-04-13

# Get the gender
national_id.gender
# => female

# Get the age
national_id.age
# => 99
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rubynor/norwegian_national_id_parser. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Credits

![rubynor](http://rubynor.com/wp-content/uploads/2016/12/cropped-Rubynor_div.logoer-nettsidebanner.png)
