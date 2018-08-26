module Web
  module Views
    module Editions
      module Navigation
        class Show < ::Html::Navigation::Item
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
