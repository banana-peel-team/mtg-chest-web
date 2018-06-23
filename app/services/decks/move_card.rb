module Services
  module Decks
    module MoveCard
      extend self

      def to_slot(deck_card, slot)
        deck_card.update(slot: slot)
      end
    end
  end
end
