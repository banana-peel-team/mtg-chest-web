module Queries
  module Cards
    def self.card(card_id)
      Card
        .where(id: card_id)
        .select(
          Sequel.qualify(:cards, :id).as(:card_id),
          Sequel.qualify(:cards, :name).as(:card_name),
          Sequel.qualify(:cards, :converted_mana_cost).as(:converted_mana_cost),
          Sequel.qualify(:cards, :toughness).as(:toughness),
          Sequel.qualify(:cards, :power).as(:power),
          Sequel.qualify(:cards, :loyalty).as(:loyalty),
          Sequel.qualify(:cards, :mana_cost).as(:mana_cost),
          Sequel.qualify(:cards, :color_identity).as(:color_identity),
          Sequel.qualify(:cards, :colors).as(:colors),
          Sequel.qualify(:cards, :type).as(:type),
          Sequel.qualify(:cards, :types).as(:types),
          Sequel.qualify(:cards, :subtypes).as(:subtypes),
          Sequel.qualify(:cards, :supertypes).as(:supertypes),
          Sequel.qualify(:cards, :text).as(:text),
          Sequel.qualify(:cards, :layout).as(:layout),
        )
        .first
    end

    def self.collection_cards(dataset)
      dataset
        .order(Sequel.asc(Sequel.qualify(:card, :name)))
        .group_and_count(
          Sequel.qualify(:card, :id).as(:card_id),
          Sequel.qualify(:card, :name).as(:card_name),
          Sequel.qualify(:card, :converted_mana_cost).as(:converted_mana_cost),
          Sequel.qualify(:card, :toughness).as(:toughness),
          Sequel.qualify(:card, :power).as(:power),
          Sequel.qualify(:card, :loyalty).as(:loyalty),
          Sequel.qualify(:card, :mana_cost).as(:mana_cost),
          Sequel.qualify(:card, :color_identity).as(:color_identity),
          Sequel.qualify(:card, :types).as(:types),
          Sequel.qualify(:card, :subtypes).as(:subtypes),
          Sequel.qualify(:card, :supertypes).as(:supertypes),
        )
        .all
    end
  end
end
