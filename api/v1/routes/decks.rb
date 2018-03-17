module API
  module V1
    module Routes
      class Decks < API::Server
        define do
          on(get, root) do
            decks = Queries::Decks.for_user(current_user)

            json(decks: API::V1::Presenters::Deck.list(decks))
          end

          on(':id') do |id|
            on(get, root) do
              deck_cards = Queries::DeckCards.for_deck(current_user, id)

              json(
                cards: API::V1::Presenters::UserPrinting.list(deck_cards)
              )
            end
          end
        end
      end
    end
  end
end
