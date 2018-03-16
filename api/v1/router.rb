require_relative 'routes/auth'
require_relative 'routes/collection'
require_relative 'routes/decks'

module API
  module V1
    class Router < API::Server
      define do
        on('collection') { run(API::V1::Routes::Collection) }
        on('decks') { run(API::V1::Routes::Decks) }
        on('auth') { run(API::V1::Routes::Auth) }

        on('status') do
          on(get, root) do
            res.write('{"status":"ok","version":"1.0"}')
          end
        end
      end
    end
  end
end
