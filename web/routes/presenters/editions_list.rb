module Web
  module Routes
    module Presenters
      module EditionsList
        extend self

        def context
          {
            editions: {
              list: Queries::Editions.list.all,
            },
          }
        end
      end
    end
  end
end
