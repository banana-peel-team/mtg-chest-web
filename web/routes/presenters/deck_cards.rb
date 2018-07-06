require_relative 'extensions/table'

module Web
  module Routes
    module Presenters
      class DeckCards
        def initialize(user, deck, options)
          @user = user
          @deck = deck

          @params = options[:params] || {}
        end

        def context
          {
            cards: Extensions::Table.table(cards, @params, {
              sort: Queries::DeckCards,
              paginate: false,
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
          Queries::DeckCards.for_deck(deck[:id])
        end
      end
    end
  end
end
