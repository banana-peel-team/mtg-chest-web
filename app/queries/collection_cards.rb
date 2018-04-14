module Queries
  module CollectionCards
    def self.owned_printings(user, card_id)
      user.user_printings_dataset
        .association_join(:import, printing: [:edition, :card])
        .where(Sequel.qualify(:card, :id) => card_id)
        .select(
          Sequel.qualify(:user_printings, :id).as(:user_printing_id),
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
          Sequel.qualify(:card, :scores).as(:card_scores),
          Sequel.qualify(:printing, :multiverse_id).as(:multiverse_id),
          Sequel.qualify(:printing, :flavor).as(:flavor),
          Sequel.qualify(:printing, :number).as(:number),
          Sequel.qualify(:printing, :rarity).as(:rarity),
          Sequel.qualify(:user_printings, :condition).as(:condition),
          Sequel.qualify(:user_printings, :added_date).as(:added_date),
          Sequel.qualify(:user_printings, :foil).as(:foil),
          Sequel.qualify(:edition, :name).as(:edition_name),
          Sequel.qualify(:edition, :code).as(:edition_code),
          Sequel.qualify(:import, :title).as(:import_title),
          Sequel.qualify(:import, :id).as(:import_id),
        )
        .all
    end

    def self.full_for_user(user)
      user.user_printings_dataset
        .association_join(printing: [:edition, :card])
        .order(Sequel.asc(Sequel.qualify(:card, :name)))
        .group_and_count(
          Sequel.qualify(:card, :id).as(:card_id),
          Sequel.qualify(:card, :scores).as(:card_scores),
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
          Sequel.qualify(:printing, :multiverse_id).as(:multiverse_id),
          Sequel.qualify(:printing, :flavor).as(:flavor),
          Sequel.qualify(:printing, :number).as(:number),
          Sequel.qualify(:printing, :rarity).as(:rarity),
          Sequel.qualify(:edition, :name).as(:edition_name),
          Sequel.qualify(:edition, :code).as(:edition_code),
        )
        .all
    end

    def self.for_user(user)
      Queries::Cards.collection_cards(
        user.user_printings_dataset
          .association_join(printing: :card)
      )
    end
  end
end
