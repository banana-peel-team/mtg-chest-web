module API
  module V1
    module Presenters
      module UserPrinting
        def self.list(printings)
          printings.map { |printing| single(printing) }
        end

        def self.single(printing)
          {
            name: printing[:name],
            edition_name: printing[:edition_name],
          }
        end
      end
    end
  end
end
