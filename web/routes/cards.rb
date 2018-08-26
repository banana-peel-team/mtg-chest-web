require_relative 'presenters/cards/database'

require_relative '../views/cards/database'

module Web
  module Routes
    class Cards < Web::Server
      define do
        require_login!

        on(get, root) do
          presenter = Presenters::Cards::Database.new(current_user, {
            params: req.params,
          })

          render_view(Views::Cards::Database.static, presenter.context)
        end
      end
    end
  end
end
