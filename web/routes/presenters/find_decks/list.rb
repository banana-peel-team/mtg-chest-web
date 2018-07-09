require_relative '../extensions/table'

module Web
  module Routes
    module Presenters
      module FindDecks
        class List
          def initialize(user, options)
            @user = user
            @params = options[:params]
          end

          def context
            {
              decks: Extensions::Table.table(decks, @params, {
                sort: Queries::Decks,
                default_sort: 'count',
                default_dir: 'desc',
                sort_columns: [
                  'deck_name',
                  'count',
                  'format',
                  'source',
                ],
                paginate: true,
              }),
            }
          end

          private

          def decks
            Queries::Decks.suggestions(@user)
          end
        end
      end
    end
  end
end
