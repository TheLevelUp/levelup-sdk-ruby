require 'vcr'

FILTERED_REQUEST_BODY_KEYS = {
  'api_key' => '<APIKEY>',
  'app_access_token' => '<APPTOKEN>',
  'client_secret' => '<CLIENTSECRET>',
  'merchant_access_token' => '<MERCHANTTOKEN>',
  'password' => '<PASSWORD>'
}

FILTERED_REQUEST_HEADERS = {
  'Authorization' => '<ACCESSTOKENS>'
}

FILTERED_RESPONSE_BODY_KEYS = {
  'token' => '<ACCESSTOKEN>'
}

FILTERED_RESPONSE_HEADERS = {
  'Set-Cookie' => '<SESSION>'
}

VCR.configure do |config|
  FILTERED_REQUEST_BODY_KEYS.each do |key, replacement|
    config.filter_sensitive_data(replacement) do |interaction|
      regex = /"#{key}":\s*"(.*?)"/
      matches = regex.match(interaction.request.body)
      matches && matches[1]
    end
  end

  FILTERED_REQUEST_HEADERS.each do |header, replacement|
    config.filter_sensitive_data(replacement) do |interaction|
      header_val = interaction.request.headers[header]
      header_val && header_val.first
    end
  end

  FILTERED_RESPONSE_BODY_KEYS.each do |key, replacement|
    config.filter_sensitive_data(replacement) do |interaction|
      regex = /"#{key}":\s*"(.*?)"/
      matches = regex.match(interaction.response.body)
      matches && matches[1]
    end
  end

  FILTERED_RESPONSE_HEADERS.each do |header, replacement|
    config.filter_sensitive_data(replacement) do |interaction|
      header_val = interaction.response.headers[header]
      header_val && header_val.first
    end
  end
end
