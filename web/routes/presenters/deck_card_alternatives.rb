require_relative 'extensions/table'

module Web
  module Routes
    module Presenters
      class DeckCardAlternatives
        def initialize(user, deck, card, options)
          @user = user
          @deck = deck
          @card = card
          @params = options[:params]
        end

        def context
          {
            cards: Extensions::Table.table(cards, @params, {
              sort: Queries::Cards,
              default_sort: 'score',
              default_dir: 'desc',
              sort_columns: [
                'score',
                'card_name',
                'cmc',
                'identity',
                'power',
                'toughness',
              ],
            }),
            rated_decks: rated_decks,
            deck: deck,
            card: card,
          }
        end

        private

        def rated_decks
          DeckDatabase.select(:key, :name, :max_score).all
        end

        def deck
          @deck
        end

        def card
          @card
        end

        def cards
          Queries::DeckCards.alternatives(
            @user, @deck[:id], @card
          )
        end
      end
    end
  end
end
