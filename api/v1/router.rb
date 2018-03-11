require_relative 'routes/auth'
require_relative 'routes/collection'

module API
  module V1
    class Router < API::Server
      define do
        on('collection') { run(API::V1::Routes::Collection) }
        on('auth') { run(API::V1::Routes::Auth) }

        on('status') do
          on(get, root) do
            res.write('OK')
          end
        end
      end
    end
  end
end
