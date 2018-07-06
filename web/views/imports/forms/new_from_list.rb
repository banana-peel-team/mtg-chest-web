require_relative '../../components/form'
require_relative '../../components/button_group'
require_relative '../../components/forms/hidden'
require_relative '../../components/forms/text'
require_relative '../../components/forms/select'
require_relative '../../components/forms/submit'
require_relative '../../components/forms/checkbox'
require_relative '../../components/forms/textarea'
require_relative '../../components/form_row'
require_relative '../../components/form_group'
require_relative '../../components/col'

module Web
  module Views
    module Imports
      module Forms
        class NewFromList < Components::Form
          def build_elements
            [
              Components::Forms::Text.new({
                name: child_name('title'),
                label: 'Title',
                required: true,
              }),
              Components::FormRow.new([
                Components::Col.new(width: 5),
                Components::Col.new([
                  Components::Forms::Checkbox.new({
                    name: child_name('foil'),
                    label: 'Foil',
                    inline: true,
                  }),
                ], width: 2),
                Components::Col.new([
                  Components::Forms::Select.new({
                    name: child_name('condition'),
                    options: {
                      'MN' => 'Mint',
                      'NM' => 'Near Mint',
                      'LP' => 'Lightly Played',
                      'MP' => 'Moderately Played',
                      'HP' => 'Heavily Played',
                      'DM' => 'Damaged',
                    },
                  }),
                ], width: 3),
                Components::Col.new([
                  Components::Forms::Text.new({
                    name: child_name('set'),
                    label: 'Set code',
                    required: true,
                  }),
                ]),
              ]),
              Components::FormRow.new([
                Components::Forms::Textarea.new({
                  name: child_name('list'),
                  label: 'Cards',
                  placeholder: '1 Swamp',
                }),
              ]),
              Components::Forms::Submit.new(label: 'Import'),
            ]
          end

          def method(_context)
            'post'
          end

          def action(context)
            '/collection/import-list'
          end
        end
      end
    end
  end
end
