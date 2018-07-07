module API
  module V1
    module Presenters
      module Deck
        def self.list(decks)
          decks.map { |deck| single(deck) }
        end

        def self.single(deck)
          {
            deck_id: deck[:deck_id],
            deck_name: deck[:deck_name],
            card_count: deck[:deck_cards],
            deck_date: deck[:deck_date],
          }
        end
      end
    end
  end
end
