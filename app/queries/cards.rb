module Queries
  module Cards
    extend self

    CARD_FIELDS = [
      Sequel[:card][:id].as(:card_id),
      Sequel[:card][:name].as(:card_name),
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
    ].freeze

    DECK_CARD_FIELDS = [
      Sequel[:deck_card][:id].as(:deck_card_id),
    ].freeze

    COLLECTION_FIELDS = [
      Sequel[:printing][:rarity].as(:printing_rarity),
      Sequel[:edition][:code].as(:edition_code),
      Sequel[:user_printing][:foil].as(:is_foil),
      Sequel[:user_printing][:id].as(:user_printing_id)
    ].freeze

    def sort_power(ds, dir)
      if dir == :asc
        ds.order_append(
          Sequel.asc(Sequel.function(:length, :power), nulls: :last),
          Sequel.asc(:power, nulls: :last),
          Sequel.asc(Sequel.function(:length, :toughness), nulls: :last),
          Sequel.asc(:toughness, nulls: :last),
        )
      else
        ds.order_append(
          Sequel.desc(Sequel.function(:length, :power), nulls: :last),
          Sequel.desc(:power, nulls: :last),
          Sequel.desc(Sequel.function(:length, :toughness), nulls: :last),
          Sequel.desc(:toughness, nulls: :last),
        )
      end
    end

    def sort_toughness(ds, dir)
      if dir == :asc
        ds.order_append(
          Sequel.asc(Sequel.function(:length, :toughness), nulls: :last),
          Sequel.asc(:toughness, nulls: :last),
          Sequel.desc(Sequel.function(:length, :power), nulls: :last),
          Sequel.desc(:power, nulls: :last),
        )
      else
        ds.order_append(
          Sequel.desc(Sequel.function(:length, :toughness), nulls: :last),
          Sequel.desc(:toughness, nulls: :last),
          Sequel.desc(Sequel.function(:length, :power), nulls: :last),
          Sequel.desc(:power, nulls: :last),
        )
      end
    end

    def sort_no_creatures(ds)
      ds.order_append(
        Sequel.asc(
          Sequel.pg_array(Sequel[:card][:types])
          .overlaps(Sequel.pg_array(['Land'], :varchar))
        ),
        Sequel.asc(
          Sequel.pg_array(Sequel[:card][:types])
          .overlaps(Sequel.pg_array(['Sorcery', 'Instant'], :varchar))
        ),
      )
    end

    def sort_score(ds, dir)
      if dir == :asc
        ds.order_append(
          Sequel.asc(:scores),
        )
      else
        ds.order_append(
          Sequel.desc(:scores)
        )
      end
    end

    def sort_name(ds, dir)
      if dir == :asc
        ds.order_append(Sequel.asc(:card_name))
      else
        ds.order_append(Sequel.desc(:card_name))
      end
    end

    def sort_cost(ds, dir)
      if dir == :asc
        ds.order_append(
          Sequel.asc(converted_mana_cost: 0),
          Sequel.asc(:converted_mana_cost),
          Sequel.asc(Sequel.function(:length, :mana_cost)),
          Sequel.desc(:scores),
        )
      else
        ds.order_append(
          Sequel.desc(:converted_mana_cost),
          Sequel.desc(Sequel.function(:length, :mana_cost)),
        )
      end
    end

    def sort_identity(ds, dir)
      if dir == :asc
        ds.order_append(
          Sequel.asc(
            Sequel.function(:array_length, :color_identity, 1),
            nulls: :last
          ),
          Sequel.asc(:color_identity),
        )
      else
        ds.order_append(
          Sequel.desc(
            Sequel.function(:array_length, :color_identity, 1),
            nulls: :last
          ),
          Sequel.desc(:color_identity),
        )
      end
    end

    # FIXME: Not working.
    # TODO: Move to DeckCards
    def sort_owned(ds, dir)
      if dir == :asc
        ds.order_append(
          Sequel.desc(Sequel[:collection][:count] => 0),
          #Sequel.desc(Sequel.gte(:count, Sequel[:collection][:count]))
          Sequel.asc(Sequel.lit('count') >= Sequel[:collection][:count])
        )
      else
        ds.order_append(
          Sequel.asc(Sequel[:collection][:count] => 0),
          Sequel.asc(Sequel.lit('count') >= Sequel[:collection][:count])
        )
      end
    end

    def sort(ds, column, dir)
      case column
      when 'score'
        sort_score(ds, dir)
      when 'card_name'
        sort_name(ds, dir)
      when 'identity'
        sort_identity(ds, dir)
      #when 'tags'
        # TODO
      when 'power'
        sort_no_creatures(
          sort_toughness(
            sort_power(ds, dir), :asc))
      when 'toughness'
        sort_no_creatures(
          sort_power(
            sort_toughness(ds, dir), :asc))
      when 'cmc'
        sort_cost(ds, dir)
      # TODO: Move to DeckCards
      when 'owned'
        sort_owned(ds, dir)
      else
        ds
      end
    end

    def filter_identity(ds, colors)
      ds
        .where(
          Sequel
            .pg_array(Sequel[:card][:color_identity])
            .contained_by(Sequel.pg_array(colors, :varchar))
        )
    end

    def card(card_id)
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

    def cards(dataset)
      dataset
        .order(Sequel.asc(Sequel[:card][:name]))
        .select_group(*CARD_FIELDS)
        .select_append(Sequel.function(:count).*.as(:card_count))
    end

    # TODO: Find a better name.
    # This will add a flag for cards on collection
    def cards_with_collection(dataset)
      dataset
        .group_and_count(
          *CARD_FIELDS,
          Sequel[:collection][:count].as(:in_collection)
        )
    end

    def deck_cards(dataset)
      dataset
        .order(Sequel.asc(Sequel[:card][:name]))
        .group_and_count(*CARD_FIELDS, *DECK_CARD_FIELDS)
    end

    def same_identity(card, dataset)
      dataset.where(
        color_identity: card[:color_identity]
      )
    end

    def collection_cards(dataset, group = true)
      dataset = dataset

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
