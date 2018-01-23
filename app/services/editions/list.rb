module Services
  module Editions
    module List
      def self.perform
        Edition
          .order(Sequel.desc(:release_date))
          .all
      end
    end
  end
end
