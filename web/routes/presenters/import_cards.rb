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
              sort: Queries::DeckCards,
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
          Queries::ImportPrintings.for_import(import)
        end
      end
    end
  end
end
