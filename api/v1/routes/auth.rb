module API
  module V1
    module Routes
      class Auth < API::Server
        define do
          on(post, root) do
            params = req.params

            user = Services::Users::Signin.perform(
              params['username'], params['password']
            ) or unauthorized!('Invalid credentials')

            secret = settings[:jwt_secret]

            token = JWT.encode(user, secret, 'HS256')
            res.headers['HTTP_AUTHORIZATION'] = token

            json(user)
          end
        end
      end
    end
  end
end
