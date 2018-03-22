module API
  module V1
    module Presenters
      module CollectionCardDetails
        def self.single(printing)
          API::V1::Presenters::Card.single(printing).merge(
            API::V1::Presenters::CollectionCard.single(printing)
          )
        end
      end
    end
  end
end
