require 'httparty'

require 'levelup/errors/invalid_request'
require 'levelup/errors/unauthenticated'
require 'levelup/configuration'

require 'levelup/templates/data_parcel'
require 'levelup/templates/user_address_data'
require 'levelup/templates/merchant_authenticated'
require 'levelup/templates/merchant_and_user_authenticated'
require 'levelup/templates/user_authenticated'

require 'levelup/requests/base'
require 'levelup/requests/authenticate_app'
require 'levelup/requests/authenticate_merchant'
require 'levelup/requests/create_address'
require 'levelup/requests/create_card'
require 'levelup/requests/create_order'
require 'levelup/requests/create_user'
require 'levelup/requests/get_order'
require 'levelup/requests/get_qr_code'
require 'levelup/requests/get_user'
require 'levelup/requests/give_merchant_credit'
require 'levelup/requests/list_app_locations'
require 'levelup/requests/list_addresses'
require 'levelup/requests/list_locations'
require 'levelup/requests/list_orders'
require 'levelup/requests/list_user_orders'
require 'levelup/requests/refund_order'
require 'levelup/requests/request_permissions'
require 'levelup/requests/show_permissions_request'

require 'levelup/responses/success'
require 'levelup/responses/success_paginated'
require 'levelup/responses/error'

require 'levelup/endpoints/base'
require 'levelup/endpoints/access_tokens'
require 'levelup/endpoints/app_locations'
require 'levelup/endpoints/app_users'
require 'levelup/endpoints/apps'
require 'levelup/endpoints/credit_cards'
require 'levelup/endpoints/location_orders'
require 'levelup/endpoints/merchant_funded_credits'
require 'levelup/endpoints/merchant_locations'
require 'levelup/endpoints/merchant_orders'
require 'levelup/endpoints/orders'
require 'levelup/endpoints/permissions_requests'
require 'levelup/endpoints/qr_codes'
require 'levelup/endpoints/specific_app'
require 'levelup/endpoints/specific_location'
require 'levelup/endpoints/specific_merchant'
require 'levelup/endpoints/specific_order'
require 'levelup/endpoints/specific_permissions_request'
require 'levelup/endpoints/user_addresses'
require 'levelup/endpoints/user_orders'
require 'levelup/endpoints/users'

require 'levelup/api'
