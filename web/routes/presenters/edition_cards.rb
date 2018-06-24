require_relative 'extensions/table'

module Web
  module Routes
    module Presenters
      class EditionCards
        attr_reader :edition
        attr_reader :user

        def initialize(edition, user, options)
          @edition = edition
          @user = user
          @params = options[:params]
        end

        def context
          {
            printings: Extensions::Table.table(printings, @params, {
              paginate: true,
              sort: Queries::DeckCards,
            }),
            edition: edition,
            rated_decks: rated_decks,
          }
        end

        private

        def rated_decks
          DeckDatabase.select(:key, :name, :max_score).all
        end

        def printings
          Queries::EditionPrintings.for_edition(edition[:code], user)
        end
      end
    end
  end
end
