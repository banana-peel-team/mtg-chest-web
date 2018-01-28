module Queries
  module ImportCards
    def self.for_import(import)
      import.user_printings_dataset
        .association_join(:printing => :card)
        .select(
          Sequel.qualify(:user_printings, :count).as(:count),
          Sequel.qualify(:card, :name).as(:name)
        )
        .all
    end
  end
end
