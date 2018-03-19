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
          }
        end
      end
    end
  end
end
