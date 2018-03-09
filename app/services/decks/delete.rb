module Services
  module Decks
    module Delete
      def self.deck(deck_id)
        DB.transaction do
          DeckCard.where(deck_id: deck_id).delete
          Deck.where(id: deck_id).delete
        end
      end
    end
  end
end
