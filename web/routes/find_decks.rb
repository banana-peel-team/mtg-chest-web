require_relative 'presenters/find_decks/list'
require_relative 'presenters/find_decks/show'

require_relative '../views/find_decks/list'
require_relative '../views/find_decks/show'

module Web
  module Routes
    class FindDecks < Web::Server
      Presenters = Routes::Presenters::FindDecks
      define do
        require_login!

        on(root) do
          on(get) do
            presenter = Presenters::List.new(current_user, {
              params: req.params,
            })

            render_view(Web::Views::FindDecks::List, presenter.context)
          end
        end

        on('(\d+)') do |deck_id|
          deck = Deck.find(id: deck_id)
          not_found! unless deck

          on(get, root) do
            presenter = Presenters::Show.new(current_user, deck, {
              params: req.params,
            })

            render_view(Web::Views::FindDecks::Show, presenter.context)
          end
        end
      end
    end
  end
end
