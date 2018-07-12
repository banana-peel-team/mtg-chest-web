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
        ds.order_append(Sequel.asc(:created_at))
      else
        ds.order_append(Sequel.desc(:created_at))
      end
    end

    def sort_name(ds, dir)
      if dir == :asc
        ds.order_append(Sequel.asc(:deck_name))
      else
        ds.order_append(Sequel.desc(:deck_name))
      end
    end

    def sort_format(ds, dir)
      if dir == :asc
        ds.order_append(
          Sequel.asc(:event_format),
        ).order_append { sum(:required) - sum(:owned) }
      else
        ds.order_append(
          Sequel.desc(:event_format),
        ).order_append { sum(:required) - sum(:owned) }
      end
    end

    def sort_source(ds, dir)
      if dir == :asc
        ds.order_append(
          Sequel.asc(:deck_database_name),
          Sequel.desc(:count),
        )
      else
        ds.order_append(
          Sequel.desc(:deck_database_name),
          Sequel.desc(:count),
        )
      end
    end

    def sort_count(ds, dir)
      if dir == :asc
        ds.order_append { sum(:required) - sum(:owned) }
      else
        ds.order_append { sum(:owned) - sum(:required) }
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

    # FIXME: Not working
    def suggestions(user)
      in_decks = DeckCard
        .in_deck
        .group_and_count(:deck_id, :card_id)

      collection = user
        .user_printings_dataset
        .not_in_decks
        .association_join(:printing)
        .group_and_count(:user_id, :card_id)

      cards = Deck
        .from_self(alias: :deck)
        .association_join(deck_metadata: :deck_database)
        .select(
          Sequel[:deck][:id].as(:deck_id),
          Sequel[:deck][:name].as(:deck_name),
          Sequel[:collection][:user_id],
          Sequel[:in_decks][:card_id],
          Sequel[:in_decks][:count].as(:required),
          Sequel[:deck_database][:name].as(:deck_database_name),
          Sequel[:deck_metadata][:event_format],
          Sequel.case(
            {
              (Sequel[:collection][:count] > Sequel[:in_decks][:count]) =>
                Sequel[:in_decks][:count],
              { Sequel[:collection][:count] => nil } => 0,
            },
            Sequel[:collection][:count]
          ).as(:owned),
        )
        .join(Sequel.as(in_decks, :in_decks), deck_id: :id)
        .left_join(Sequel.as(collection, :collection), card_id: :card_id)

      DB[
        Sequel.as(cards, :deck),
      ].select(
        Sequel[:deck][:deck_id],
        Sequel[:deck][:deck_name],
        Sequel[:deck][:event_format],
        Sequel[:deck][:deck_database_name],
        Sequel.function(:sum, :required).as(:required_count),
        Sequel.function(:sum, :owned).as(:owned_count),
        Sequel[:deck][:deck_database_name],
        Sequel[:deck][:event_format],
      ).group(
        Sequel[:deck][:deck_id],
        Sequel[:deck][:deck_name],
        Sequel[:deck][:deck_database_name],
        Sequel[:deck][:event_format],
      )
    end
  end
end
