module Web
  module Views
    module Decks
      module Forms
        class SuggestionsFilter < ::Html::Component
          def draw
            namespace = nest_into(options[:namespace], :i)

            ::Html::Component.new(
              ::Html::Form::Checkbox.new(
                label: 'Show un-owned',
                inline: true,
                source: :all,
                name: nest_into(options[:namespace], 'a'),
              ),
              Cards::Forms::IdentityFilter.new(options),
            )
          end
        end
      end
    end
  end
end
