require_relative 'deck_cards'

module Web
  module Routes
    module Presenters
      class EditDeckCards < DeckCards
        def context
          super.merge(
            scratchpad: { list: scratchpad, count: scratchpad.count },
          )
        end

        private

        def scratchpad
          Queries::DeckCards.scratchpad(deck[:id]).all
        end

        def cards
          Queries::DeckCards.for_edit_deck(deck[:id])
        end
      end
    end
  end
end
