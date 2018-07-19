require_relative 'imports'
require_relative 'decks'

module Queries
  module UserPrintings
    extend self

    def sort(ds, column, dir)
      case column
      when 'import_name'
        Imports.sort_name(ds, dir)
      when 'deck_name'
        Decks.sort_name(ds, dir)
      else
        Cards.sort(ds, column, dir)
      end
    end

    def owned_printings(user, card_id)
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
    end

    def full_for_user(user)
      user.user_printings_dataset
        .association_join(:import, printing: [:edition, :card])
        .association_left_join(deck_cards: :deck)
        .group_and_count(
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
          Sequel[:deck][:id].as(:deck_id),
          Sequel[:deck][:name].as(:deck_name),
          Sequel[:import][:id].as(:import_id),
          Sequel[:import][:title].as(:import_title),
        )
    end

    def for_user(user)
      Queries::Cards.collection_cards(
        user.user_printings_dataset
          .from_self(alias: :user_printing)
          .association_join(printing: [:edition, :card])
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
