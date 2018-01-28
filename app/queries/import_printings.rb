module Queries
  module ImportPrintings
    def self.for_import(import)
      import.user_printings_dataset
        .association_join(:printing => [:card, :edition])
        .select_all(:card, :user_printings)
        .select_more(
          Sequel.qualify(:card, :id).as(:card_id),
          Sequel.qualify(:edition, :name).as(:edition_name),
          Sequel.qualify(:edition, :code).as(:edition_code),
        )
        .all
    end
  end
end
