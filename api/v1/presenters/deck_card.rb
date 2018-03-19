module API
  module V1
    module Presenters
      module DeckCard
        def self.list(cards)
          cards.map { |card| single(card) }
        end

        def self.single(card)
          {
            deck_card_id: card[:deck_card_id],
            card_name: card[:card_name],
            card_id: card[:card_id],
          }
        end
      end
    end
  end
end
