require_relative '../extensions/table'

module Web
  module Routes
    module Presenters
      module FindDecks
        class Show
          def initialize(user, deck, options)
            @user = user
            @deck = deck
            @params = options[:params]
          end

          def context
            {
              cards: Extensions::Table.table(cards, @params, {
                sort: Queries::Cards,
                default_sort: 'card_name',
                #default_dir: 'desc',
                sort_columns: [
                  'owned',
                  'card_name',
                  'cmc',
                  'identity',
                  'power',
                  'toughness',
                ],
                paginate: true,
              }),
              deck: deck,
              rated_decks: rated_decks,
            }
          end

          private

          def rated_decks
            DeckDatabase.select(:key, :name, :max_score).all
          end

          def deck
            @deck
          end

          def cards
            Queries::DeckCards.for_user_on_deck(@user, deck[:id])
          end
        end
      end
    end
  end
end
