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

    def sort(ds, column, dir)
      case column
      when 'deck_name'
        sort_name(ds, dir)
      when 'deck_date'
        sort_date(ds, dir)
      end
    end
  end
end
