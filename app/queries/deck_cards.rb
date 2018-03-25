module Queries
  module DeckCards
    def self.for_deck(user, deck_id)
      Queries::Cards.collection_cards(
        DeckCard
          .association_join(:deck, :card)
          .where(deck_id: deck_id, user_id: user[:id])
      )
    end

    def self.alternatives(user, deck_id, card)
      cards = Sequel[:card]

      deck_cards = DeckCard.where(deck_id: deck_id)
      cards_in_decks = DeckCard
        .association_join(:deck)
        .where(user_id: user[:id])

      ds = user.user_printings_dataset
        .association_join(printing: :card)
        .where(
          cards[:color_identity] => card[:color_identity],
        )
        .exclude(
          cards[:id] => deck_cards.select(:card_id),
        )
        .exclude(
          cards[:id] => cards_in_decks.select(:card_id),
        )

      if card.subtypes
        ds = ds.where(Sequel.pg_array(:subtypes).overlaps(card.subtypes))
      elsif card.types
        ds = ds.where(Sequel.pg_array(:types).overlaps(card.types))
      end

      if card.converted_mana_cost
        cmc = card.converted_mana_cost

        ds = ds.where('converted_mana_cost BETWEEN ? AND ?', cmc - 1, cmc + 1)
      end

      Queries::Cards.collection_cards(ds)
    end

    def self.synergy(user, deck_id, card)
      cards = Sequel[:cards]

      deck_cards = DeckCard.where(deck_id: deck_id)
      cards_in_decks = DeckCard
        .association_join(:deck)
        .where(user_id: user[:id])

      ds = Card
        .first(id: card[:card_id])
        .related_cards_dataset
        .association_join(printings: :user_printings)
        .exclude(
          cards[:id] => deck_cards.select(:card_id),
        )
        .exclude(
          cards[:id] => cards_in_decks.select(:card_id),
        )
        .where(
          Sequel[:user_printings][:user_id] => user[:id],
          cards[:color_identity] => card[:color_identity],
        )

      Queries::Cards.collection_cards(ds, :cards)
    end
  end
end
