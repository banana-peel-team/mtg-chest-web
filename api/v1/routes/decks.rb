module API
  module V1
    module Routes
      class Decks < API::Server
        define do
          on(get, root) do
            decks = Queries::Decks.for_user(current_user)

            json(decks: API::V1::Presenters::Decks.list(decks))
          end
        end
      end
    end
  end
end
