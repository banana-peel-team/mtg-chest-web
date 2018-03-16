module API
  module V1
    module Routes
      class Auth < API::Server
        define do
          on(post, root) do
            user = Services::Users::Signin.perform(
              json_body['username'], json_body['password']
            ) or unauthorized!('Invalid credentials')

            secret = settings[:jwt_secret]

            token = JWT.encode(user, secret, 'HS256')
            res.headers['AUTHORIZATION'] = "Bearer #{token}"

            json(user)
          end
        end
      end
    end
  end
end
