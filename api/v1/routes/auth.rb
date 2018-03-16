module API
  module V1
    module Routes
      class Auth < API::Server
        define do
          on(post, root) do
            body = req.body.read

            # FIXME: Use body instead of params!
            if body.empty?
              body = req.params
            else
              body = JSON.parse(body)
            end

            user = Services::Users::Signin.perform(
              body['username'], body['password']
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
