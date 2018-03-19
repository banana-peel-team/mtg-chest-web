require_relative 'support/web'
require_relative 'support/definitions/printing'
require_relative 'support/definitions/user_printing'
require_relative 'support/definitions/deck'
require_relative 'support/definitions/deck_card'
require_relative 'support/definitions/user'
require_relative 'support/definitions/card'
require_relative 'support/examples/secure_api_endpoint'

require 'rack/test'
require './http'

RSpec.configure do |config|
  config.include(Rack::Test::Methods)
  config.include(Support::Web)
end
