module Queries
  module DeckCards
    def self.for_deck(user, deck_id)
      DeckCard
        .association_join(:deck, :card)
        .where(deck_id: deck_id, user_id: user[:id])
        .order(Sequel.asc(Sequel.qualify(:card, :name)))
        .select(
          Sequel.qualify(:deck_cards, :id).as(:deck_card_id),
          Sequel.qualify(:card, :id).as(:card_id),
          Sequel.qualify(:card, :name).as(:card_name),
        )
        .all
    end
  end
end
