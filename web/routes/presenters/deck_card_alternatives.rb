module Web
  module Routes
    module Presenters
      class DeckCardAlternatives
        def initialize(user, deck, card)
          @user = user
          @deck = deck
          @card = card
        end

        def context
          {
            cards: { list: cards },
            rated_decks: rated_decks,
            deck: deck,
            card: card,
          }
        end

        private

        def rated_decks
          DeckDatabase.select(:key, :name, :max_score).all
        end

        def deck
          @deck
        end

        def card
          @card
        end

        def cards
          Queries::DeckCards.alternatives(
            @user, @deck[:id], @card
          ).all
        end
      end
    end
  end
end
