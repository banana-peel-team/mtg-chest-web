module Queries
  module ImportCards
    def self.for_import(import)
      Queries::Cards.collection_cards(
        import.user_printings_dataset
          .from_self(alias: :user_printing)
          .association_join(printing: [:edition, :card])
      )
    end
  end
end
