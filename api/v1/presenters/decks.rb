module API
  module V1
    module Presenters
      module Decks
        def self.list(decks)
          decks.map { |deck| single(deck) }
        end

        def self.single(deck)
          {
            name: deck[:name],
          }
        end
      end
    end
  end
end
