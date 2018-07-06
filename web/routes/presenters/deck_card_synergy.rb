module Web
  module Routes
    module Presenters
      class DeckCardSynergy
        def initialize(user, deck, card)
          @user = user
          @deck = deck
          @card = card
        end

        def context
          {
            cards: { list: cards },
            card: card,
            deck: deck,
            rated_decks: rated_decks,
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
          Queries::DeckCards.synergy(
            @user, @deck[:id], @card
          ).all
        end
      end
    end
  end
end
