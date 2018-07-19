module API
  module V1
    module Presenters
      module Decks
        module List
          extend self

          def present(user, decks)
            params = {}

            API::V1::Presenters::Extensions::Table.table(decks, params, {
              paginate: false
            })
          end
        end
      end
    end
  end
end
