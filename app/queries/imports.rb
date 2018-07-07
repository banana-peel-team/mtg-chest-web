module Queries
  module Imports
    extend self

    def sort_name(ds, dir)
      if dir == :asc
        ds.order(Sequel.asc(:import_title))
      else
        ds.order(Sequel.desc(:import_title))
      end
    end

    def for_user(user)
      user.imports_dataset.select(
        Sequel[:imports][:id].as(:import_id),
        Sequel[:imports][:title].as(:import_title),
        Sequel[:imports][:created_at],
        Sequel[:imports][:user_printing_count].as(:import_cards_count),
      )
    end

    def for_import(import)
      # TODO: Merge with CollectionCards.full_for_user
      import.user_printings_dataset
        .association_join(printing: [:edition, :card])
        .order(Sequel.asc(Sequel.qualify(:card, :name)))
        .group_and_count(
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
          Sequel[:printing][:rarity].as(:card_rarity),
          Sequel[:printing][:number].as(:card_number),
          Sequel[:printing][:flavor].as(:card_flavor),
          Sequel[:printing][:multiverse_id].as(:multiverse_id),
          Sequel[:edition][:code].as(:edition_code),
          Sequel[:edition][:name].as(:edition_name),
        )
    end
  end
end
