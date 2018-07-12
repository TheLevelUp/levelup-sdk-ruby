**DEPRECATION WARNING:** This gem is now deprecated. Please do not use it for new projects since it is unmaintained.

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

## Documentation

[![Documentation](http://img.shields.io/badge/docs-rdoc.info-blue.svg)](http://rubydoc.org/gems/levelup/frames)

## Usage

### Do once per LevelUp-powered application:
-  Create an instance of the LevelUp client and authenticate it.

```ruby
api = Levelup::Api.new

# While testing:
Levelup::Configuration.base_api_url = 'https://sandbox.thelevelup.com/'

# For production, these should be ENV variables:
api_key = '23eef8c2895ce66eb4500bb5e324b200f5339e6fe6d8665f6de0205f43f3b563'
client_secret = '4d71e958b9fb6a62af624390c4ef394df15d168ea12b3b12735643ff0694520f'

auth_response = api.access_tokens.create_for_app(
  api_key: api_key,
  client_secret: client_secret)

api.app_access_token = auth_response.token
```

### Do once per merchant account

- Authenticate merchants using LevelUp email and password

```ruby
username = 'sandboxdevexample@thelevelup.com'
password = 'fod2yau4flu6vok6'

merchant_token = api.access_tokens.create_for_merchant(
  api_key: api_key, username: username, password: password)
```

### Do for each merchant location

- Prompt merchant to map LevelUp locations to each of their online ordering locations

```ruby
locations_response = api.merchants(merchant_id).locations.list(merchant_access_token)

# For testing purposes, we'll use the first location

location = locations_response.locations[0]
location_id = location.id
```

### Do for each customer

- Ask a user for permission to make an order for them (alternatively you can use our
[OpenID](http://developer.thelevelup.com/resources-and-guides/web-authentication-flow/) or
[Oauth2](http://developer.thelevelup.com/resources-and-guides/web-authorization-flow/) flows). 
For more information on available permissions, see the
[LevelUp permissions list](http://developer.thelevelup.com/resources-and-guides/permissions-list/)

```ruby
api.apps.permissions_requests.create(
  email: 'user@email.com',
  permission_keynames: ['create_orders', 'read_qr_code'])
# wait for the user to approve the request. you will receive a user
# access token in the same manner as above.
```

- Retrieve a user's QR code

```ruby
qr_code_response = api.qr_codes.get(customer_token)

qr_code = qr_code_response.code
```

- Create an order for the specified merchant.

```ruby

# Check for merchant_funded_credit

discount_response = api.locations(location_id).merchant_funded_credit.get(
  qr_code, merchant_access_token)

# Define the details from the check

check_total_due_including_tax = 110 # Total amount of payment due on the check (in cents)
exempted_item_total = 0 # Total amount of exempted (milk, cigarettes etc) items (in cents)
spend_amount_requested = 110 # Total amount of payment requested from LevelUp (in cents)
tax_amount_due = 10 # Total tax amount due on check (in cents)
identifier_from_merchant = '01234' # Unique check identifier in your platform (ie, check ID)
check_items_array = [ # Array of all items on the check
    {
      charged_price: 350,
      description: 'Non-poisonous, supplies vital nutrients',
      name: 'Food',
      quantity: 1,
      sku: '123abc',
      category: 'Edible Things',
      standard_price: 350
    }
    # more items can go here
  ]

# Determine the amount of discount to apply to the check

credit_to_apply = Levelup::Utils::PaymentCalculator.levelup_discount_to_apply(
  check_total_due_including_tax: check_total_due_including_tax,
  exempted_item_total: exempted_item_total,
  merchant_funded_credit_available: discount_response.discount_amount,  
  payment_amount_requested: spend_amount_requested,
  tax_amount_due: tax_amount_due,
)

# Apply the discount to the check

# Create a new order request
order_response = api.orders.create(
  identifier_from_merchant: identifier_from_merchant,
  location_id: location_id,
  spend_amount: spend_amount_requested,
  items: check_items_array,
  merchant_access_token: merchant_access_token,
  user_access_token: qr_code)

calculator = Levelup::Utils::PaymentCalculator.new(
  discount_applied: credit_to_apply,
  gift_card_credit_available: discount_response.gift_card_amount,
  spend_amount_returned_from_levelup: order_response.spend_amount,
  tip_returned_from_levelup: order_response.tip_amount
)

# Get relevant amounts to apply to check and apply as necessary

calculator.gift_card_payment_to_apply
calculator.gift_card_tip_to_apply
calculator.levelup_payment_to_apply
calculator.levelup_tip_to_apply

# Additional values are also available (if desired)

calculator.total_gift_card_payment_to_apply_including_tip
calculator.gift_card_remaining_balance_after_payment
calculator.total_levelup_payment_to_apply_including_tip

# Apply each payment to the check and close the check (assuming balance due is 0)
```

The LevelUp Ruby SDK mirrors the API as closely as possible, so the call for any given endpoint
can be inferred from its URL.

For instance:

```ruby
api.apps.permissions_requests.create # points to /v15/apps/permissions_requests/ POST
api.user_addresses.list              # points to /v15/user_addresses/ GET
api.orders(uuid).refund              # points to /v15/orders/:uuid/refund/ POST
```

## Pagination

Some requests that return large lists are paginated and only return a small number of values per
request. The LevelUp Ruby SDK handles this by allowing you to request the next page from the
paginated response.

For instance:

```ruby
locs_response = api.apps(123).locations.list # gets a page of locations associated with an app
locs_response.locations # => [location 1, location 2...location 10]

locs_response.next_page? # => true if there is another page of results to load

next_page_response = locs_response.next # gets the next page of results
```

## Errors

If the LevelUp API returns a 422 error response, it will also return an object containing useful
info about the error. It can be handled like so:

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

-  Fork it (https://github.com/TheLevelup/levelup-sdk-ruby/fork)
-  Create your feature branch (`git checkout -b my-new-feature`)
-  Ensure that Rubocop gives you a clean bill of health
```
cd path/to/my/ruby-sdk-folder
bundle exec rubocop
```
-  Ensure that all RSpec tests pass (and write some for your code!)
```
cd path/to/my/ruby-sdk-folder
bundle exec rspec
```
-  Commit your changes (`git commit -am 'Add some feature'`)
-  Push to the branch (`git push origin my-new-feature`)
-  Create a new Pull Request
