require_relative 'deck_cards'

module Web
  module Routes
    module Presenters
      class EditDeckCards < DeckCards
        def ignored
          @ignored ||= Queries::DeckCards.ignored(deck[:id]).all
        end

        def scratchpad
          @scratchpad ||= Queries::DeckCards.scratchpad(deck[:id]).all
        end

        def cards
          @cards ||= Queries::DeckCards.for_edit_deck(deck[:id]).all
        end
      end
    end
  end
end
