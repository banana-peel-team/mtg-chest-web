module Queries
  module Editions
    def self.list
      Edition
        .order(Sequel.desc(:release_date))
        .all
    end
  end
end
