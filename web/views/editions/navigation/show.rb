require_relative '../../components/navigation_item'

module Web
  module Views
    module Editions
      module Navigation
        class Show < Components::NavigationItem
          private
          def item_values(context)
            edition = context[options[:edition]]

            [edition[:name], "/editions/#{edition[:code]}"]
          end
        end
      end
    end
  end
end
