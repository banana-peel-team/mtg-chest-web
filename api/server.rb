require 'cuba'
require 'rack/jwt'
require 'rack/cors'

require './app/application'

require_relative 'v1/presenters'
require_relative 'helpers/common_helper'

module API
  class Server < Cuba
    use(Rack::Cors) do
      allow do
        resource('*', {
          headers: :any,
          methods: :any,
          vary: ['Origin', 'Authorization'],
          expose: 'Authorization',
        })
        origins('*')
      end
    end

    use(Rack::JWT::Auth, secret: ENV['JWT_SECRET'],
                         options: { algorithm: 'HS256' },
                         # TODO: Can we handle this in the routes?
                         exclude: [
                           '/v1/status',
                           '/v1/auth',
                           '/v1/cards',
                         ])

    plugin(API::Helpers::CommonHelper)
  end
end

API::Server.settings[:jwt_secret] = ENV['JWT_SECRET']

require_relative 'v1/router'

API::Server.define do
  on('v1') { run(API::V1::Router) }
end
