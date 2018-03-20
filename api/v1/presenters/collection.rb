module API
  module V1
    module Presenters
      module Collection
        def self.list(printings)
          printings.map do |printing|
            API::V1::Presenters::CollectionCard.single(printing)
          end
        end
      end
    end
  end
end
