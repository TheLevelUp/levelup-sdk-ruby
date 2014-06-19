# LevelUp Ruby SDK

Early alpha version of the LevelUp Ruby SDK - designed for e-commerce and online
food ordering sites to provide the option to easily pay with a LevelUp account.

Subject to drastic change without warning for duration of alpha period.

## Installation

Add this line to your application's Gemfile:

    gem 'levelup'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install levelup

## Usage

1. Create an instance of the LevelUp client and authenticate it.

```ruby
api = Levelup::Api.new
auth_response = api.access_tokens.create_for_app(
  api_key: 'your_api_key',
  client_secret: 'your_secret')
api.app_access_token = auth_response.token

# or if you've saved your access token (recommended) just:
api = Levelup::Api.new(app_access_token: 'your_access_token')
```

2. Ensure you have permissions to manage orders for your merchant (if you haven't already done so)

```ruby
api.apps.permissions_requests.create(
  email: 'merchant@email.com',
  permission_keynames: ['manage_merchant_orders'])
# Approve the request through the merchant email and the LevelUp API
# will post you a merchant access token.

# See http://developer.thelevelup.com/api-reference/v15/user-permissions/
# for more on receiving access tokens.
```

3. Ask a user for permission to make an order for them.

```ruby
api.apps.permissions_requests.create(
  email: 'user@email.com',
  permission_keynames: ['create_orders'])
# wait for the user to approve the request. you will receive a user
# access token in the same manner as above.
```

3. Create an order for the specified merchant.

```ruby
response = api.orders.create(
  identifier_from_merchant: '0123',
  location_id: 321,
  spend_amount: 350, # in cents; 350 = $3.50
  items: [
    {
      # item data
    }
  ],
  merchant_access_token: 'merchant-token',
  user_access_token: 'user-token')
```

All other functions of the Ruby SDK mirror the v15 LevelUp API described at http://developer.thelevelup.com/
as well as a very small number of v14 endpoints.

## Errors

If the LevelUp API returns an error response (Any HTTP code 400 or greater), it will return an object
containing useful info about the error. It can be handled like so:
```ruby
error = api.access_tokens.create_for_app(
  api_key: 'bogus_api_key',
  client_secret: 'bogus_client_secret'
)

puts error.success? # => false
puts error.headers['Cache-Control'] # => 'private' (Map of header names to values)
puts error.status_code # => 422
puts error.errors[0] # => object with message, object, property values
puts error.errors[0].message # => 'API Key is invalid.'
puts error.errors[0].property # => 'api_key'
```

## Contributing

1. Fork it ( https://github.com/TheLevelup/pos-ruby-sdk/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Ensure that Rubocop gives you a clean bill of health
```
cd path/to/my/ruby-sdk-folder
rubocop
```
4. Ensure that all RSpec tests pass (and write some for your code!)
```
cd path/to/my/ruby-sdk-folder
rspec
```
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new Pull Request
