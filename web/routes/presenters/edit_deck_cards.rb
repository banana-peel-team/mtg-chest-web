require_relative 'deck_cards'

module Web
  module Routes
    module Presenters
      class EditDeckCards < DeckCards
        def context
          super.merge(
            scratchpad: Extensions::Table.table(scratchpad, @params, {
              sort: Queries::Cards,
              default_sort: 'card_name',
              sort_columns: [
                'score',
                'card_name',
                'cmc',
                'identity',
                'power',
                'toughness',
              ],
              paginate: true,
            }),
          )
        end

        private

        def scratchpad
          Queries::DeckCards.scratchpad(deck[:id])
        end

        def cards
          Queries::DeckCards.for_edit_deck(deck[:id])
        end
      end
    end
  end
end
