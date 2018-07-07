require_relative '../component'
require_relative '../components/forms/checkbox'
require_relative '../cards/forms/identity_filter'

module Web
  module Views
    module Decks
      class SuggestionsFilter < Component
        def build_elements
          [
            Components::Forms::Checkbox.new(
              label: 'Show un-owned',
              inline: true,
              source: :all,
              name: child_name('a'),
            ),
            Cards::Forms::IdentityFilter.new(options),
          ]
        end

        private

        def children_context(context)
          context.merge({
            _current_form_values: context[options[:source]][:filters],
          })
        end
      end
    end
  end
end
