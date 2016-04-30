# envGen

EnvGen is a basic gem that write file and gem dependencies to your environment file.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'envGen'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install envGen

## Usage

USAGE:
envGen [option]

OPTIONS:
init                : Initialize environment.rb file
file [file], [file] : Add file to environment, e.g. 'lib/test1.rb'
dir [dir]           : Add all .rb files in directory to environment. e.g. 'lib'
gem [gem], [gem]    : Add gem to environment using exact name
gem -s [gem]        : Search on partial gem name
help                : Display this message

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/envGen. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
