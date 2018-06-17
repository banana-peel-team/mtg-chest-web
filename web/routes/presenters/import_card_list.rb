module Web
  module Routes
    module Presenters
      class ImportCardList
        attr_reader :import

        def initialize(import)
          @import = import
        end

        def cards
          Queries::ImportCards.for_import(import).all
        end
      end
    end
  end
end
