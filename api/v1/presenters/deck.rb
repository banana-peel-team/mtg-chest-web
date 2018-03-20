module API
  module V1
    module Presenters
      module Deck
        def self.list(decks)
          decks.map { |deck| single(deck) }
        end

        def self.single(deck)
          {
            deck_id: deck[:id],
            deck_name: deck[:name],
            card_count: deck[:card_count],
            deck_date: deck[:created_at],
          }
        end
      end
    end
  end
end
