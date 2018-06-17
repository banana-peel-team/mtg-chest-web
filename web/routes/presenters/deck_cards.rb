module Web
  module Routes
    module Presenters
      class DeckCards
        def initialize(user, deck)
          @user = user
          @deck = deck
        end

        def rated_decks
          @rated_decks ||= DeckDatabase.select(:key, :name, :max_score).all
        end

        def deck
          @deck
        end

        def ignored
          @ignored ||= Queries::DeckCards.ignored(deck[:id]).all
        end

        def scratchpad
          @scratchpad ||= Queries::DeckCards.scratchpad(deck[:id]).all
        end

        def cards
          @cards ||= Queries::DeckCards.for_deck(deck[:id]).all
        end
      end
    end
  end
end
