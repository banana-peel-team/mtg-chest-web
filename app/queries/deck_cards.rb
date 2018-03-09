module Queries
  module DeckCards
    def self.for_deck(deck_id)
      DeckCard
        .association_join(:card)
        .where(deck_id: deck_id)
        .order(Sequel.asc(:name))
        .select_more(Sequel.qualify(:deck_cards, :card_count).as(:count))
        .all
    end
  end
end
