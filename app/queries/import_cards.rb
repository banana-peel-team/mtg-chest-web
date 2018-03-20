module Queries
  module ImportCards
    def self.for_import(import)
      Queries::Cards.collection_cards(
        import.user_printings_dataset
          .association_join(printing: :card)
      )
      .all
    end
  end
end
