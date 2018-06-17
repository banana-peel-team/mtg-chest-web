module Queries
  class EditionPrintings
    def self.for_edition(code, user = nil)
      dataset = Printing
        .from_self(alias: :printing)
        .association_join(:card, :edition)
        .where(edition_code: code)
        .select(
          Sequel[:card][:id].as(:card_id),
          Sequel[:card][:scores].as(:card_scores),
          Sequel[:card][:name].as(:card_name),
          Sequel[:card][:converted_mana_cost].as(:converted_mana_cost),
          Sequel[:card][:toughness].as(:toughness),
          Sequel[:card][:power].as(:power),
          Sequel[:card][:loyalty].as(:loyalty),
          Sequel[:card][:mana_cost].as(:mana_cost),
          Sequel[:card][:color_identity].as(:color_identity),
          Sequel[:card][:colors].as(:colors),
          Sequel[:card][:type].as(:type),
          Sequel[:card][:types].as(:types),
          Sequel[:card][:subtypes].as(:subtypes),
          Sequel[:card][:supertypes].as(:supertypes),
          Sequel[:card][:text].as(:card_text),
          Sequel[:card][:layout].as(:layout),
          Sequel[:printing][:multiverse_id].as(:multiverse_id),
          Sequel[:printing][:flavor].as(:flavor),
          Sequel[:printing][:number].as(:number),
          Sequel[:printing][:rarity].as(:card_rarity),
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
