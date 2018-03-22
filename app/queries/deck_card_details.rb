module Queries
  module DeckCardDetails
    def self.for_deck_card(deck_id, card_id)
      DeckCard
        .association_join(:card)
        .order(Sequel.asc(Sequel.qualify(:card, :name)))
        .where(
          Sequel.qualify(:deck_cards, :deck_id) => deck_id,
          Sequel.qualify(:deck_cards, :card_id) => card_id,
        )
        .group_and_count(
          Sequel.qualify(:card, :id).as(:card_id),
          Sequel.qualify(:card, :name).as(:card_name),
          Sequel.qualify(:card, :converted_mana_cost).as(:converted_mana_cost),
          Sequel.qualify(:card, :toughness).as(:toughness),
          Sequel.qualify(:card, :power).as(:power),
          Sequel.qualify(:card, :loyalty).as(:loyalty),
          Sequel.qualify(:card, :mana_cost).as(:mana_cost),
          Sequel.qualify(:card, :color_identity).as(:color_identity),
          Sequel.qualify(:card, :colors).as(:colors),
          Sequel.qualify(:card, :type).as(:type),
          Sequel.qualify(:card, :types).as(:types),
          Sequel.qualify(:card, :subtypes).as(:subtypes),
          Sequel.qualify(:card, :supertypes).as(:supertypes),
          Sequel.qualify(:card, :text).as(:text),
          Sequel.qualify(:card, :layout).as(:layout),
        )
        .first
    end
  end
end
