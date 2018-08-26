require_relative 'presenters/home'

require_relative '../views/home'

module Web
  module Routes
    class Home < Web::Server
      define do
        on(get, root) do
          presenter = Presenters::Home.new(current_user)

          render_view(Views::Home.static, presenter.context)
        end
      end
    end
  end
end
