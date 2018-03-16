module Queries
  module Decks
    def self.for_user(user)
      Deck
        .where(user_id: user[:id])
        .order(Sequel.desc(:created_at))
        .all
    end
  end
end
