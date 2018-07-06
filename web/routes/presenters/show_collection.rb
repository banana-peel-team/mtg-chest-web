require_relative 'extensions/table'

module Web
  module Routes
    module Presenters
      class ShowCollection
        attr_reader :user

        def initialize(user, options = {})
          @user = user

          @params = options[:params] || {}
        end

        def context
          {
            printings: Extensions::Table.table(cards, @params, {
              sort: Queries::DeckCards,
              paginate: true,
            }),
            rated_decks: rated_decks,
          }
        end

        private

        def rated_decks
          DeckDatabase.select(:key, :name, :max_score).all
        end

        def cards
          Queries::CollectionCards.full_for_user(user)
        end
      end
    end
  end
end
