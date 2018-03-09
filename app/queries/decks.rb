module Queries
  module Decks
    def self.list
      Deck
        .order(Sequel.desc(:created_at))
        .all
    end
  end
end
