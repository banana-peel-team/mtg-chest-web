module API
  module V1
    module Presenters
      module DeckCard
        def self.list(cards)
          cards.map do |card|
            API::V1::Presenters::CollectionCard.single(card)
          end
        end

        def self.details(card)
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
