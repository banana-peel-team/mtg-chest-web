module Queries
  module EditionCards
    extend self

    def for_edition(code, user = nil)
      dataset = Printing
        .from_self(alias: :printing)
        .association_join(:card, :edition)
        .where(edition_code: code)
        .select(
          Sequel[:card][:id].as(:card_id),
          Sequel[:card][:scores].as(:card_scores),
          Sequel[:card][:name].as(:card_name),
          Sequel[:card][:converted_mana_cost].as(:card_converted_mana_cost),
          Sequel[:card][:toughness].as(:card_toughness),
          Sequel[:card][:power].as(:card_power),
          Sequel[:card][:loyalty].as(:card_loyalty),
          Sequel[:card][:mana_cost].as(:card_mana_cost),
          Sequel[:card][:color_identity].as(:card_color_identity),
          Sequel[:card][:colors].as(:card_colors),
          Sequel[:card][:type].as(:card_type),
          Sequel[:card][:types].as(:card_types),
          Sequel[:card][:subtypes].as(:card_subtypes),
          Sequel[:card][:supertypes].as(:card_supertypes),
          Sequel[:card][:text].as(:card_card_text),
          Sequel[:card][:layout].as(:card_layout),
          Sequel[:printing][:multiverse_id].as(:printing_multiverse_id),
          Sequel[:printing][:flavor].as(:printing_flavor),
          Sequel[:printing][:number].as(:printing_number),
          Sequel[:printing][:rarity].as(:printing_rarity),
          Sequel[:edition][:name].as(:edition_name),
          Sequel[:edition][:code].as(:edition_code),
        )
        .order(
          Sequel[:card][:scores]
        ).reverse
        .exclude(
          'Land' => Sequel.pg_array(Sequel[:card][:types]).any
        )

      if user
        dataset = dataset.select_append {
          UserPrinting
            .where(
              printing_id: Sequel[:printing][:id],
              user_id: user[:id],
            )
            .select(Sequel.lit('COUNT(*)'))
            .as(:collection_count)
        }
      end

      dataset
    end
  end
end
