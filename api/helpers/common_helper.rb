module API
  module Helpers
    module CommonHelper
      def current_user
        @current_user ||= begin
          user_id = env['jwt.payload']['id']
          User.find(id: user_id)
        end
      end

      def json(hash)
        res.headers['Content-Type'] = 'application/json'
        res.write(JSON.generate(hash))
      end

      def unprocessable!
        error!('Unprocessable', status: 422)
      end

      def unauthorized!(description = nil)
        description ||= 'Not authorized'

        error!(description, status: 403)
      end

      def not_found!
        error!('Not found', status: 404)
      end

      def error!(description, status:)
        json(error: description)
        res.status = status

        halt(res.finish)
      end
    end
  end
end
