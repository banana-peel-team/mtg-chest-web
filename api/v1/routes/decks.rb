module API
  module V1
    module Routes
      class Decks < API::Server
        define do
          on(get, root) do
            decks = Queries::Decks.for_user(current_user)

            json(
              API::V1::Presenters::Decks::List.present(current_user, decks)
            )
          end

          on(':id') do |deck_id|
            deck = Queries::Decks.by_id(deck_id)
            #not_found! unless deck

            on(get, root) do
              json(
                API::V1::Presenters::Decks::Show.present(current_user, deck)
              )
            end

            on('cards/:card_id') do |card_id|
              on(get, 'alternatives') do
                card = Card.find(id: card_id)

                cards = Queries::DeckCards
                  .alternatives(current_user, deck_id, card)
                  .all

                json(cards: API::V1::Presenters::DeckCard.list(cards))
              end
            end
          end
        end
      end
    end
  end
end
