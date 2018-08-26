require_relative 'presenters/import_cards'
require_relative 'presenters/edition_cards'
require_relative 'presenters/editions_list'

require_relative '../views/editions/list'
require_relative '../views/editions/show'
require_relative '../views/imports/show'

module Web
  module Routes
    class Editions < Web::Server
      define do
        on(get, root) do
          context = Presenters::EditionsList.context(req.params)

          render_view(Web::Views::Editions::List.static, context)
        end

        on(':code') do |code|
          edition = Edition.where(code: code).first

          on(get, root) do
            presenter = Presenters::EditionCards.new(edition, current_user, {
              params: req.params,
            })

            render_view(Views::Editions::Show.static, presenter.context)
          end
        end
      end
    end
  end
end
