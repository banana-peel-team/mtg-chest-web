require_relative 'presenters/import_cards'
require_relative 'presenters/edition_cards'

require_relative '../views/editions/list'
require_relative '../views/editions/show'
require_relative '../views/imports/show'

module Web
  module Routes
    class Editions < Web::Server
      define do
        on(get, root) do
          editions = Queries::Editions.list.all

          render_view(Web::Views::Editions::List, {
            editions: editions,
          })
        end

        on(':code') do |code|
          edition = Edition.where(code: code).first

          on(get, root) do
            presenter = Presenters::EditionCards.new(edition, current_user)

            render_view(Views::Editions::Show, presenter: presenter)
          end
        end
      end
    end
  end
end
