require_relative 'presenters/signin'

require_relative '../views/sessions/new'

module Web
  module Routes
    class Sessions < Web::Server
      define do
        on(get, 'new') do
          presenter = Presenters::Signin.new(errors: {})

          render_view(Views::Sessions::New, presenter.context)
        end

        on(post, root, param('signin')) do |attributes|
          user = Services::Users::Signin.perform(
            attributes['username'],
            attributes['password']
          )

          if user
            session[:user_id] = user[:id]

            redirect_to('/home')
          else
            presenter = Presenters::Signin.new(
              values: { username: attributes['username'] },
              errors: { username: [:invalid], password: true }
            )

            res.status = 422

            render_view(Views::Sessions::New, presenter.context)
          end
        end

        on(post, 'delete') do
          session.delete(:user_id)
          redirect_to('/sessions/new')
        end

        on(get, root) do
          redirect_to('/sessions/new')
        end
      end
    end
  end
end
