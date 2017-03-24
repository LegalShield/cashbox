# Vindicia

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'vindicia-rest'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install vindicia-rest

## Usage

#### Requiring

```ruby
require "vindicia-rest"
```

#### Setup

The library needs to be configured with your account's username & password which is available from your account rep. To configure the gem run:

```ruby
Vindicia.config({ username: 'me', password: 'sekret' })
```

or

```ruby
Vindicia.config do |c|
  c.username = 'me'
  c.password = 'sekret'
end
```

#### Switch Environments

```ruby
>> Vindicia.production!
=> "https://api.vindicia.com"

>> Vindicia.sandbox!
=> "https://api.prodtest.vindicia.com"

>> Vindicia.test!
=> "http://example.com"
# also sets
# Vindicia.username == 'username'
# Vindicia.password == 'password'
```

#### Fetching

```ruby
Vindicia::Product.all => [#<Vindicia::Product object="Product">, ...]

Vindicia::Product.where(status: 'Active') => [#<Vindicia::Product object="Product">, ...]

Vindicia::Product.first => #<Vindicia::Product object="Product">
```

#### Finding

```ruby
Vindicia::Product.find("6fd70003fdb24c3b8104ccfccab4bb492b27a326") => #<Vindicia::Product object="Product">
Vindicia::Product.find("my-user-defined-id") => #<Vindicia::Product object="Product">

product = Vindicia::Product.first
product_by_id  = Vindicia::Product.find(product.id)
product_by_vid = Vindicia::Product.find(product.vid)

product_by_id == product_by_vid
=> true

product_by_id === product_by_vid
=> true
```

#### Saving

```ruby
account = Vindicia::Account.find(self.vid)
account.email = "new_email@example.com"
account.name = "New Name"
account.save
```

## Development

After checking out the repo, run `bundle install` to install dependencies. Then, run `bundle exec rake` to run the tests. You can also run `bundle console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/LegalShield/vindicia-rest. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).