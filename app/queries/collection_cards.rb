module Queries
  module CollectionCards
    def self.for_user(user)
      user.user_printings_dataset
        .association_join(printing: [:edition, :card])
        .select_more(
          Sequel.qualify(:edition, :name).as(:edition_name)
        )
        .all
    end
  end
end
