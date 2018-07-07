require_relative 'extensions/table'

module Web
  module Routes
    module Presenters
      class UserDecks
        def initialize(user, options)
          @user = user
          @params = options[:params]
        end

        def context
          {
            decks: Extensions::Table.table(decks, @params, {
              sort: Queries::Decks,
              default_sort: 'deck_name',
              sort_columns: [
                'deck_name',
                'deck_date',
              ],
              paginate: true,
            }),
          }
        end

        private

        def decks
          Queries::Decks.for_user(@user)
        end
      end
    end
  end
end
