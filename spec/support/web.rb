module Support
  module Web
    def app
      Cuba
    end

    def auth(user, options = {})
      options.merge()
    end

    def jwt_secret
      ENV['JWT_SECRET']
    end

    def jwt_header(user, header = {})
      payload = { id: user[:id] }

      header.merge(
        'HTTP_AUTHORIZATION' =>
          "Bearer #{JWT.encode(payload, jwt_secret, 'HS256')}"
      )
    end

    def json_response
      JSON.parse(last_response.body)
    end
  end
end
