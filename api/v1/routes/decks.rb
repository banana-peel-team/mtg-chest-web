module API
  module V1
    module Routes
      class Decks < API::Server
        define do
          on(get, root) do
            decks = Queries::Decks.for_user(current_user)

            json(decks: API::V1::Presenters::Deck.list(decks))
          end

          on(':id') do |deck_id|
            on(get, root) do
              deck_cards = Queries::DeckCards
                .for_deck(current_user, deck_id)

              json(
                cards: API::V1::Presenters::DeckCard.list(deck_cards)
              )
            end

            on('cards') do
              on(':id') do |id|
                deck_card = Queries::DeckCardDetails.for_deck_card(
                  deck_id, id
                )

                not_found! unless deck_card

                json(
                  details: API::V1::Presenters::DeckCard.details(deck_card)
                )
              end
            end
          end
        end
      end
    end
  end
end
