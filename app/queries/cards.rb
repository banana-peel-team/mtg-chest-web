module Queries
  module Cards
    CARD_FIELDS = [
      Sequel[:card][:id].as(:card_id),
      Sequel[:card][:name].as(:card_name),
      Sequel[:card][:text].as(:card_text),
      Sequel[:card][:converted_mana_cost].as(:converted_mana_cost),
      Sequel[:card][:toughness].as(:toughness),
      Sequel[:card][:power].as(:power),
      Sequel[:card][:loyalty].as(:loyalty),
      Sequel[:card][:mana_cost].as(:mana_cost),
      Sequel[:card][:color_identity].as(:color_identity),
      Sequel[:card][:types].as(:types),
      Sequel[:card][:subtypes].as(:subtypes),
      Sequel[:card][:supertypes].as(:supertypes),
      Sequel[:card][:scores].as(:card_scores),
    ].freeze

    DECK_CARD_FIELDS = [
      Sequel[:deck_card][:id].as(:deck_card_id),
    ].freeze

    COLLECTION_FIELDS = [
      Sequel[:printing][:rarity].as(:card_rarity),
      Sequel[:edition][:code].as(:edition_code),
      Sequel[:user_printing][:id].as(:user_printing_id)
    ].freeze

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
    end

    def self.cards(dataset)
      dataset
        .order(Sequel.asc(Sequel[:card][:name]))
        .group_and_count(*CARD_FIELDS)
    end

    def self.deck_cards(dataset)
      dataset
        .order(Sequel.asc(Sequel[:card][:name]))
        .group_and_count(*CARD_FIELDS, *DECK_CARD_FIELDS)
    end

    def self.collection_cards(dataset, group = true)
      dataset = dataset
        .order(Sequel.asc(Sequel[:card][:name]))

      if group
        # FIXME:
        # Grouping by user_printing_id makes no sense
        dataset = dataset.group_and_count(*CARD_FIELDS, *COLLECTION_FIELDS)
      else
        dataset = dataset.select(*CARD_FIELDS, *COLLECTION_FIELDS)
      end
    end
  end
end
