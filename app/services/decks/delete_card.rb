module Services
  module Decks
    module DeleteCard
      extend self

      def delete_deck_card(deck_card)
        DB.transaction do
          deck_card.update(removed_at: Time.now.utc)

          if deck_card[:slot] == 'deck'
            Deck.where(id: deck_card[:deck_id]).update(
              card_count: Sequel.-(:card_count, 1)
            )
          end
        end
      end
    end
  end
end
