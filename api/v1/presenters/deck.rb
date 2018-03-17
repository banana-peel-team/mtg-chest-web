module API
  module V1
    module Presenters
      module Deck
        def self.list(decks)
          decks.map { |deck| single(deck) }
        end

        def self.single(deck)
          {
            id: deck[:id],
            name: deck[:name],
          }
        end
      end
    end
  end
end
