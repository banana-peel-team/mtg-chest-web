module API
  module V1
    module Routes
      class Cards < API::Server
        define do
          on(':card_id') do |card_id|
            on(get, root) do
              card = Queries::Cards.card(card_id).first

              not_found! unless card

              json(details: API::V1::Presenters::Card.single(card))
            end
          end
        end
      end
    end
  end
end
