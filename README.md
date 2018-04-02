# Cashbox

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
Cashbox.config({ username: 'me', password: 'sekret' })
```

or

```ruby
Cashbox.config do |c|
  c.username = 'me'
  c.password = 'sekret'
end
```

#### Switch Environments

```ruby
>> Cashbox.production!
=> "https://api.vindicia.com"

>> Cashbox.sandbox!
=> "https://api.prodtest.vindicia.com"

>> Cashbox.test!
=> "http://example.com"
# also sets
# Cashbox.username == 'username'
# Cashbox.password == 'password'
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

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/LegalShield/cashbox. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
