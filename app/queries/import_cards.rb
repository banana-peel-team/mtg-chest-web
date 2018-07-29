module Queries
  module ImportCards
    def self.for_import(import)
      dataset = import.user_printings_dataset
        .from_self(alias: :user_printing)
        .association_join(:import, printing: [:edition, :card])
        .association_left_join(deck_cards: :deck)

      dataset = dataset.select_group(
        Sequel[:card][:id].as(:card_id),
        Sequel[:card][:name].as(:card_name),
        Sequel[:card][:names].as(:card_names),
        Sequel[:card][:text].as(:card_text),
        Sequel[:card][:converted_mana_cost].as(:card_converted_mana_cost),
        Sequel[:card][:toughness].as(:card_toughness),
        Sequel[:card][:power].as(:card_power),
        Sequel[:card][:loyalty].as(:card_loyalty),
        Sequel[:card][:layout].as(:card_layout),
        Sequel[:card][:mana_cost].as(:card_mana_cost),
        Sequel[:card][:color_identity].as(:card_color_identity),
        Sequel[:card][:colors].as(:card_colors),
        Sequel[:card][:types].as(:card_types),
        Sequel[:card][:type].as(:card_type),
        Sequel[:card][:subtypes].as(:card_subtypes),
        Sequel[:card][:supertypes].as(:card_supertypes),
        Sequel[:card][:scores].as(:card_scores),
        Sequel[:printing][:rarity].as(:printing_rarity),
        Sequel[:edition][:code].as(:edition_code),
        Sequel[:edition][:name].as(:edition_name),
        Sequel[:user_printing][:foil].as(:user_printing_is_foil),
        Sequel[:user_printing][:condition].as(:user_printing_condition),
        Sequel[:deck][:id].as(:deck_id),
        Sequel[:deck][:name].as(:deck_name),
        Sequel[:import][:id].as(:import_id),
        Sequel[:import][:title].as(:import_title),
      )
      .select_append(Sequel.function(:count).*.as(:card_count))
    end
  end
end
