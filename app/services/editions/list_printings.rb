module Services
  module Editions
    module ListPrintings
      def self.perform(code)
        Printing
          .association_join(:card)
          .where(edition_code: code)
          .all
      end
    end
  end
end
