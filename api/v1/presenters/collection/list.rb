module API
  module V1
    module Presenters
      module Collection
        module List
          extend self

          def present(user, decks, options)
            params = options[:params]

            API::V1::Presenters::Extensions::Table.table(decks, params, {

              paginate: true,
            })
          end
        end
      end
    end
  end
end
