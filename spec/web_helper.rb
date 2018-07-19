require_relative 'support/web'
require_relative 'support/examples/secure_api_endpoint'
require_relative 'support/examples/restricted_route'

require 'rack/test'
require './http'

RSpec.configure do |config|
  config.include(Rack::Test::Methods)
  config.include(Support::Web)
end
