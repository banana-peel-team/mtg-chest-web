module Queries
  module CollectionCards
    def self.for_user(user)
      user.user_printings_dataset
        .association_join(printing: [:edition, :card])
        .select(
          :multiverse_id,
          Sequel.qualify(:user_printings, :id).as(:user_printing_id),
          Sequel.qualify(:printing, :id).as(:printing_id),
          Sequel.qualify(:card, :id).as(:card_id),
          Sequel.qualify(:card, :name).as(:card_name),
          Sequel.qualify(:edition, :name).as(:edition_name),
        )
        .all
    end
  end
end
