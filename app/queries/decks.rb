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
        ).order_append { required_count - owned_count }
      else
        ds.order_append(
          Sequel.desc(:event_format),
        ).order_append { required_count - owned_count }
      end
    end

    def sort_source(ds, dir)
      if dir == :asc
        ds.order_append(
          Sequel.asc(:deck_database_name),
        ).order_append { required_count - owned_count }
      else
        ds.order_append(
          Sequel.desc(:deck_database_name),
        ).order_append { required_count - owned_count }
      end
    end

    def sort_count(ds, dir)
      if dir == :asc
        ds.order_append { required_count - owned_count }
      else
        ds.order_append { owned_count - required_count }
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
      Deck
        .from_self(alias: :deck)
        .join(Sequel.as(deck_suggestions, :suggestions), deck_id: :id)
        .association_join(deck_cards: :card, deck_metadata: :deck_database)
        .select_group(
          Sequel[:deck][:id].as(:deck_id),
          Sequel[:deck][:name].as(:deck_name),
          Sequel[:deck_metadata][:event_format].as(:event_format),
          Sequel[:deck_database][:name].as(:deck_database_name),
          Sequel[:suggestions][:required_count],
          Sequel[:suggestions][:owned_count],
        )
        .where {
          (owned_count * 100 / required_count) > 60
        }
    end

    private

    def deck_suggestions
      in_decks = DeckCard
        .in_deck
        .group_and_count(:deck_id, :card_id)

      collection = UserPrinting
        .not_in_decks
        .association_join(:printing)
        .group_and_count(:user_id, :card_id)

      cards =
        DB[
          Sequel.as(in_decks, :in_decks)
        ].left_join(
          Sequel.as(collection, :collection), card_id: :card_id
        ).select(
          Sequel[:collection][:user_id],
          Sequel[:in_decks][:card_id],
          Sequel[:in_decks][:deck_id],
          Sequel[:in_decks][:count].as(:required),
          Sequel.case(
            {
              (Sequel[:collection][:count] > Sequel[:in_decks][:count]) =>
                Sequel[:in_decks][:count],
              { Sequel[:collection][:count] => nil } => 0,
            },
            Sequel[:collection][:count]
          ).as(:owned),
        )

      DB[cards]
        .select_group(:deck_id)
        .select_append(
          Sequel.function(:sum, :required).as(:required_count),
          Sequel.function(:sum, :owned).as(:owned_count),
        )
    end
  end
end
