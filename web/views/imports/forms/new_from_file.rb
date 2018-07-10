require_relative '../../components/form'
require_relative '../../components/button_group'
require_relative '../../components/forms/hidden'
require_relative '../../components/forms/text'
require_relative '../../components/forms/select'
require_relative '../../components/forms/submit'
require_relative '../../components/forms/checkbox'
require_relative '../../components/forms/radiobox'
require_relative '../../components/forms/file'
require_relative '../../components/forms/textarea'
require_relative '../../components/form_row'
require_relative '../../components/col'

module Web
  module Views
    module Imports
      module Forms
        class NewFromFile < Components::Form
          def build_elements
            [
              Components::Forms::Text.new({
                name: child_name('title'),
                label: 'Title',
                required: true,
              }),
              Components::FormRow.new([
                Components::Col.new([
                  Components::Forms::Radiobox.new({
                    name: child_name('source'),
                    label: 'Deckbox',
                    value: 'deckbox',
                    inline: true,
                  }),
                  Components::Forms::Radiobox.new({
                    name: child_name('source'),
                    label: 'MTG Manager',
                    value: 'mtg-manager',
                    inline: true,
                  }),
                  Components::Forms::Radiobox.new({
                    name: child_name('source'),
                    label: 'Decked Builder (deck)',
                    value: 'decked-builder',
                    inline: true,
                  }),
                ], width: 8),
                Components::Col.new([
                  Components::Forms::File.new({
                    name: child_name('file'),
                    required: true,
                  }),
                ]),
              ]),
              Components::FormRow.new([
                Components::Forms::Submit.new(label: 'Import')
              ]),
            ]
          end

          def default_options
            {
              multipart: true,
            }
          end

          def method(_context)
            'post'
          end

          def action(context)
            '/collection/import'
          end
        end
      end
    end
  end
end
