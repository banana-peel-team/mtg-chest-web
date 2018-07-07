module Queries
  module Editions
    extend self

    def sort_name(ds, dir)
      if dir == :asc
        ds.order(Sequel.asc(:edition_name))
      else
        ds.order(Sequel.desc(:edition_name))
      end
    end

    def sort_date(ds, dir)
      if dir == :asc
        ds.order(Sequel.asc(:edition_date))
      else
        ds.order(Sequel.desc(:edition_date))
      end
    end

    def sort_code(ds, dir)
      if dir == :asc
        ds.order(Sequel.asc(:edition_code))
      else
        ds.order(Sequel.desc(:edition_code))
      end
    end

    def sort(ds, column, dir)
      case column
      when 'edition_name'
        sort_name(ds, dir)
      when 'edition_date'
        sort_date(ds, dir)
      when 'edition_code'
        sort_code(ds, dir)
      else
        ds
      end
    end

    def list
      Edition
        .from_self(alias: :edition)
        .select(
          Sequel[:edition][:code].as(:edition_code),
          Sequel[:edition][:name].as(:edition_name),
          Sequel[:edition][:release_date].as(:edition_date),
        )
    end
  end
end
