module Web
  module Routes
    module Presenters
      class ImportCards
        attr_reader :import

        def initialize(import)
          @import = import
        end

        def rated_decks
          @rated_decks ||= DeckDatabase.select(:key, :name, :max_score).all
        end

        def printings
          Queries::ImportPrintings.for_import(import).all
        end
      end
    end
  end
end
