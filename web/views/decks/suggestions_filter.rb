require_relative '../component'
require_relative '../components/forms/checkbox'
require_relative '../components/form_group'

require_relative 'forms/color_filter'

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
            Forms::ColorFilter.new(
              color: 'r',
              source: :identity_r,
              name: child_name('i[r]'),
            ),
            Forms::ColorFilter.new(
              color: 'g',
              source: :identity_g,
              name: child_name('i[g]'),
            ),
            Forms::ColorFilter.new(
              color: 'b',
              source: :identity_b,
              name: child_name('i[b]'),
            ),
            Forms::ColorFilter.new(
              color: 'u',
              source: :identity_u,
              name: child_name('i[u]'),
            ),
            Forms::ColorFilter.new(
              color: 'w',
              source: :identity_w,
              name: child_name('i[w]'),
            ),
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
