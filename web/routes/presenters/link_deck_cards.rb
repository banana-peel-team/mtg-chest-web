require_relative 'paginated'

module Web
  module Routes
    module Presenters
      class LinkDeckCards
        include Paginated

        def initialize(user, deck, options)
          @user = user
          @deck = deck

          super(options)
        end

        def rated_decks
          @rated_decks ||= DeckDatabase.select(:key, :name, :max_score).all
        end

        def deck
          @deck
        end

        def total_missing
          @total_missing ||=
            @deck
              .deck_cards_dataset
              .where(user_printing_id: nil, slot: 'deck')
              .count
        end

        private

        def dataset
          @dataset ||= Queries::DeckCards.for_link(deck)
        end
      end
    end
  end
end
