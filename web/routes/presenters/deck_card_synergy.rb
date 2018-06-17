module Web
  module Routes
    module Presenters
      class DeckCardSynergy
        def initialize(user, deck, card)
          @user = user
          @deck = deck
          @card = card
        end

        def rated_decks
          @rated_decks ||= DeckDatabase.select(:key, :name, :max_score).all
        end

        def deck
          @deck
        end

        def card
          @card
        end

        def cards
          @cards ||= Queries::DeckCards.synergy(
            @user, @deck[:id], @card
          ).all
        end
      end
    end
  end
end
