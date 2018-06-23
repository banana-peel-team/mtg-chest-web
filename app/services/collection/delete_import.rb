module Services
  module Collection
    module DeleteImport
      extend self

      def perform(import)
        to_update = import
          .deck_cards_dataset
          .select(Sequel[:deck_cards][:id])

        DB.transaction do
          DeckCard.where(id: to_update).update(user_printing_id: nil)
          import.user_printings_dataset.delete
          import.delete
        end
      end
    end
  end
end
