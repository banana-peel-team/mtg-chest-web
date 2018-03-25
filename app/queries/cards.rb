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

    # FIXME: card_alias workaround, look for something else
    def self.collection_cards(dataset, card_alias = :card)
      dataset
        .order(Sequel.asc(Sequel.qualify(card_alias, :name)))
        .group_and_count(
          Sequel.qualify(card_alias, :id).as(:card_id),
          Sequel.qualify(card_alias, :name).as(:card_name),
          Sequel.qualify(card_alias, :converted_mana_cost).as(:converted_mana_cost),
          Sequel.qualify(card_alias, :toughness).as(:toughness),
          Sequel.qualify(card_alias, :power).as(:power),
          Sequel.qualify(card_alias, :loyalty).as(:loyalty),
          Sequel.qualify(card_alias, :mana_cost).as(:mana_cost),
          Sequel.qualify(card_alias, :color_identity).as(:color_identity),
          Sequel.qualify(card_alias, :types).as(:types),
          Sequel.qualify(card_alias, :subtypes).as(:subtypes),
          Sequel.qualify(card_alias, :supertypes).as(:supertypes),
          Sequel.qualify(card_alias, :scores).as(:card_scores),
        )
        .all
    end
  end
end
