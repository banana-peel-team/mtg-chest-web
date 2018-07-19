require_relative 'cards'

module Queries
  module Collection
    extend self

    def for_user(user)
      dataset = user.user_printings_dataset
        .from_self(alias: :user_printing)
        .association_join(:import, printing: [:edition, :card])
        .association_left_join(deck_cards: :deck)

      dataset = dataset.select_group(
        Sequel[:card][:color_identity].as(:card_color_identity),
        Sequel[:card][:colors].as(:card_colors),
        Sequel[:card][:converted_mana_cost].as(:card_converted_mana_cost),
        Sequel[:card][:id].as(:card_id),
        Sequel[:card][:layout].as(:card_layout),
        Sequel[:card][:loyalty].as(:card_loyalty),
        Sequel[:card][:mana_cost].as(:card_mana_cost),
        Sequel[:card][:name].as(:card_name),
        Sequel[:card][:power].as(:card_power),
        Sequel[:card][:scores].as(:card_scores),
        Sequel[:card][:subtypes].as(:card_subtypes),
        Sequel[:card][:supertypes].as(:card_supertypes),
        Sequel[:card][:text].as(:card_text),
        Sequel[:card][:toughness].as(:card_toughness),
        Sequel[:card][:type].as(:card_type),
        Sequel[:card][:types].as(:card_types),
        Sequel[:deck][:id].as(:deck_id),
        Sequel[:deck][:name].as(:deck_name),
        Sequel[:edition][:code].as(:edition_code),
        Sequel[:edition][:name].as(:edition_name),
        Sequel[:import][:id].as(:import_id),
        Sequel[:import][:title].as(:import_title),
        Sequel[:printing][:rarity].as(:printing_rarity),
        Sequel[:printing][:number].as(:printing_number),
        Sequel[:printing][:multiverse_id].as(:printing_multiverse_id),
        Sequel[:user_printing][:foil].as(:user_printing_is_foil),
        Sequel[:user_printing][:condition].as(:user_printing_condition),
      )
      .select_append(Sequel.function(:count).*.as(:card_count))
    end
  end
end
