require_relative 'extensions/table'

module Web
  module Routes
    module Presenters
      class ImportCards
        attr_reader :import

        def initialize(import, params)
          @import = import
          @params = params
        end

        def context
          {
            printings: Extensions::Table.table(printings, @params, {
              sort: Queries::UserPrintings,
              default_sort: 'card_name',
              sort_columns: [
                'scores',
                'card_name',
                'cmc',
                'identity',
                'power',
                'toughness',
              ],
              paginate: true,
            }),
            import: import,
            rated_decks: rated_decks,
          }
        end

        private

        def rated_decks
          DeckDatabase.select(:key, :name, :max_score).all
        end

        def printings
          Queries::UserPrintings.for_import(import)
        end
      end
    end
  end
end
