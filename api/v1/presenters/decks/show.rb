module API
  module V1
    module Presenters
      module Decks
        module Show
          extend self

          def present(user, deck)
            cards = deck_cards(deck).map do |card|
              card.to_hash
            end

            deck.to_hash.merge(cards: cards)
          end

          private

          def deck_cards(deck)
            Queries::DeckCards
              .for_deck(deck[:deck_id])
              .all
          end
        end
      end
    end
  end
end
