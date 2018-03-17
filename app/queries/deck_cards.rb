module Queries
  module DeckCards
    def self.for_deck(user, deck_id)
      DeckCard
        .association_join(:deck, :card)
        .where(deck_id: deck_id, user_id: user[:id])
        .order(Sequel.asc(Sequel.qualify(:card, :name)))
        .select_more(Sequel.qualify(:deck_cards, :card_count).as(:count))
        .all
    end
  end
end
