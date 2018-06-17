module Services
  module Decks
    module UnlinkCard
      def self.unlink_deck_card(deck_card)
        DB.transaction do
          deck_card.update(user_printing_id: nil)
        end
      end
    end
  end
end
