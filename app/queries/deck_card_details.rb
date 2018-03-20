module Queries
  module DeckCardDetails
    def self.for_deck_card(deck_id, deck_card_id)
      DeckCard
        .association_join(:deck, :card)
        .where(
          deck_id: deck_id,
          Sequel.qualify(:deck_cards, :id) => deck_card_id,
        )
        .order(Sequel.asc(Sequel.qualify(:card, :name)))
        .select(
          Sequel.qualify(:deck_cards, :id).as(:deck_card_id),
          Sequel.qualify(:card, :id).as(:card_id),
          Sequel.qualify(:card, :name).as(:card_name),
        )
        .first
    end
  end
end
