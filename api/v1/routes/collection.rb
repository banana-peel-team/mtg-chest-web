module API
  module V1
    module Routes
      class Collection < API::Server
        define do
          on(get, root) do
            printings = Queries::Collection.for_user(current_user)

            json(
              API::V1::Presenters::Collection::List.present(
                current_user, printings,
                params: req.params
              )
            )
          end

          on(':card_id') do |card_id|
            on(get, root) do
              card = Queries::Cards.card(card_id).first
              printings = Queries::UserPrintings.owned_printings(
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
