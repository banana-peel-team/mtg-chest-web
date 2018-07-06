require_relative 'extensions/table'

module Web
  module Routes
    module Presenters
      class LinkDeckCards
        def initialize(user, deck, options)
          @user = user
          @deck = deck

          @params = options[:params]
        end

        def context
          {
            count: cards.count,
            total_missing: total_missing,
            cards: Extensions::Table.table(cards, @params, {
              sort: Queries::DeckCards,
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

        def total_missing
          @deck
            .deck_cards_dataset
            .where(user_printing_id: nil, slot: 'deck')
            .count
        end

        def cards
          Queries::DeckCards.for_link(deck)
        end
      end
    end
  end
end
