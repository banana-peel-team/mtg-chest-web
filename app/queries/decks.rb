module Queries
  module Decks
    extend self

    DATASET = Sequel[:deck]
    TABLE = Deck.from_self(alias: :deck)

    SIMPLE_COLUMNS = TABLE.select(
      DATASET[:id].as(:deck_id),
      DATASET[:name].as(:deck_name),
      DATASET[:card_count].as(:deck_cards),
      DATASET[:created_at].as(:deck_date),
    )

    def for_user(user)
      SIMPLE_COLUMNS.where(user_id: user[:id])
    end

    def sort_date(ds, dir)
      if dir == :asc
        ds.order(Sequel.asc(:created_at))
      else
        ds.order(Sequel.desc(:created_at))
      end
    end

    def sort_name(ds, dir)
      if dir == :asc
        ds.order(Sequel.asc(:deck_name))
      else
        ds.order(Sequel.desc(:deck_name))
      end
    end

    def sort_count(ds, dir)
      if dir == :asc
        ds.order(Sequel.asc(:count))
      else
        ds.order(Sequel.desc(:count))
      end
    end

    def sort_format(ds, dir)
      if dir == :asc
        ds.order(
          Sequel.asc(:event_format),
          Sequel.desc(:count),
        )
      else
        ds.order(
          Sequel.desc(:event_format),
          Sequel.desc(:count),
        )
      end
    end

    def sort_source(ds, dir)
      if dir == :asc
        ds.order(
          Sequel.asc(:deck_database_name),
          Sequel.desc(:count),
        )
      else
        ds.order(
          Sequel.desc(:deck_database_name),
          Sequel.desc(:count),
        )
      end
    end

    def sort(ds, column, dir)
      case column
      when 'deck_name'
        sort_name(ds, dir)
      when 'count'
        sort_count(ds, dir)
      when 'deck_date'
        sort_date(ds, dir)
      when 'format'
        sort_format(ds, dir)
      when 'source'
        sort_source(ds, dir)
      else
        ds
      end
    end

    def suggestions(user)
      in_decks = DeckCard
        .in_use
        .where(user_printing_id: Sequel[:user_printings][:id])

      DeckCard
        .in_deck # We could remove this if decks have no sideboard
        .association_join(:card, deck: { deck_metadata: :deck_database })
        .where(
          'Basic' => Sequel.pg_array(:supertypes).any,
          'Land' => Sequel.pg_array(:types).any,
        )
        .or(
          card_id: user
            .user_printings_dataset
            .association_join(:printing)
            .exclude(in_decks.exists)
            .select(:card_id)
        )
        .group_and_count(
          DATASET[:id].as(:deck_id),
          DATASET[:name].as(:deck_name),
          DATASET[:card_count].as(:deck_cards),
          Sequel[:deck_database][:name].as(:deck_database_name),
          Sequel[:deck_metadata][:event_format],
        )
    end
  end
end
