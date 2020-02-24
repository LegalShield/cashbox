# Cashbox

### Status

[ ![Codeship Status for LegalShield/cashbox](https://app.codeship.com/projects/02080c20-18df-0136-5060-1edfcc351556/status?branch=master)](https://app.codeship.com/projects/283978)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cashbox'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cashbox

## Usage

#### Requiring

```ruby
require "cashbox"
```

#### Setup

The library needs to be configured with your account's username & password which is available from your account rep. To configure the gem run:

```ruby
Cashbox.config do |c|
  # set your username and password
  c.username = 'me'
  c.password = 'sekret'
  
  # run in production 
  c.production!
end
```

#### Switch Environments

```ruby
Cashbox.config do |c|
  c.production!
  # sets base uri to "https://api.vindicia.com"

  c.sandbox!
  c.development!
  # sets base uri to "https://api.prodtest.vindicia.com"

  c.test!
  # sets base uri to "http://example.com"
  # sets username = 'username'
  # sets password = 'password
end
```

#### Fetching

```ruby
Cashbox::Product.all => [<Cashbox::Product object="Product">, ...]

Cashbox::Product.where(status: 'Active') => [<Cashbox::Product object="Product">, ...]

Cashbox::Product.first => <Cashbox::Product object="Product">
```

#### Finding

```ruby
Cashbox::Product.find("6fd70003fdb24c3b8104ccfccab4bb492b27a326") => <Cashbox::Product object="Product">
Cashbox::Product.find("my-user-defined-id") => <Cashbox::Product object="Product">

product = Cashbox::Product.first
product_by_id  = Cashbox::Product.find(product.id)
product_by_vid = Cashbox::Product.find(product.vid)

product_by_id == product_by_vid
=> true

product_by_id === product_by_vid
=> true
```

#### Saving

```ruby
account = Cashbox::Account.find(self.vid)
account.email = "new_email@example.com"
account.name = "New Name"
account.save
```

## Development

After checking out the repo, run `bundle install` to install dependencies. Then, run `bundle exec rake` to run the tests. You can also run `bundle console` for an interactive prompt that will allow you to experiment.

To push a new version of the Cashbox ruby gem, you will need to update the version file with the new version, run `bundle install` and be sure to also push the `Gemfile.lock` file up with your code changes to be merged to master. Then, run this command in your terminal to build the gemspec `gem build cashbox.gemspec`. Once the gemspec is built and your code has been merged to master, you can now push the new version to ruby gems by running this command in your terminal: `gem push cashbox-<version number of built gem>.gem` and replace the verbiage within the angle brackets with the new version number.

### Logging

You can log the request and response of a call to Vindicia by defining a block in your calling application and passing it to this gem.

```ruby
Cashbox::Request.after_request_log do |method, path, options, response|
  puts "Request >>>"
  puts method
  puts path
  puts options
  puts "Response >>>"
  puts response
end
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/LegalShield/cashbox. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
