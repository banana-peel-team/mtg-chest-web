module Queries
  module DeckCards
    def self.for_deck(user, deck_id)
      Queries::Cards.collection_cards(
        DeckCard
          .association_join(:deck, :card)
          .where(deck_id: deck_id, user_id: user[:id])
      )
    end
  end
end
