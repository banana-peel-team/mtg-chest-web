module Web
  module Routes
    module Presenters
      class DeckCardList
        attr_reader :deck

        def initialize(deck)
          @deck = deck
        end

        def context
          {
            cards: cards,
            deck: deck,
          }
        end

        private

        def cards
          Queries::DeckCards.for_deck(deck[:id]).all
        end
      end
    end
  end
end
