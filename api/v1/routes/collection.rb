module API
  module V1
    module Routes
      class Collection < API::Server
        define do
          on(get, root) do
            printings = Queries::CollectionCards.for_user(current_user).all

            json(cards: API::V1::Presenters::Collection.list(printings))
          end

          on(':card_id') do |card_id|
            on(get, root) do
              card = Queries::Cards.card(card_id).first
              printings = Queries::CollectionCards.owned_printings(
                current_user, card_id
              ).all

              json(
                card: API::V1::Presenters::Card.single(card),
                user_printings: API::V1::Presenters::UserPrinting.list(
                  printings
                ),
              )
            end
          end
        end
      end
    end
  end
end
