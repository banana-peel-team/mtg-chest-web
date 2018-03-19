module API
  module V1
    module Presenters
      module UserPrinting
        def self.list(printings)
          printings.map { |printing| single(printing) }
        end

        def self.single(printing)
          {
            user_printing_id: printing[:user_printing_id],
            printing_id: printing[:printing_id],
            card_id: printing[:card_id],
            card_name: printing[:card_name],
            edition_name: printing[:edition_name],
            multiverse_id: printing[:multiverse_id],
          }
        end
      end
    end
  end
end
