require_relative '../component'
require_relative '../components/forms/checkbox'
require_relative '../components/form_group'

module Web
  module Views
    module Decks
      class SuggestionsFilter < Component
        def build_elements
          [
            Components::Forms::Checkbox.new(
              label: 'Show all',
              inline: true,
              source: :all,
              name: child_name('a'),
            ),
            Components::Forms::Checkbox.new(
              label: 'r',
              inline: true,
              source: :identity_r,
              name: child_name('i[r]'),
            ),
            Components::Forms::Checkbox.new(
              label: 'g',
              inline: true,
              source: :identity_g,
              name: child_name('i[g]'),
            ),
            Components::Forms::Checkbox.new(
              label: 'b',
              inline: true,
              source: :identity_b,
              name: child_name('i[b]'),
            ),
            Components::Forms::Checkbox.new(
              label: 'u',
              inline: true,
              source: :identity_u,
              name: child_name('i[u]'),
            ),
            Components::Forms::Checkbox.new(
              label: 'w',
              inline: true,
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
