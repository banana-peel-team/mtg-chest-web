module API
  module V1
    module Routes
      class Collection < API::Server
        define do
          on(get, root) do
            printings = Queries::CollectionCards.for_user(current_user)

            json(cards: API::V1::Presenters::UserPrinting.list(printings))
          end
        end
      end
    end
  end
end
