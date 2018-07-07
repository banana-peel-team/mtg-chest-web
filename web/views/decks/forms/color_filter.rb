require_relative '../../components/forms/checkbox'

module Web
  module Views
    module Decks
      module Forms
        class ColorFilter < Components::Forms::Checkbox
          def initialize(options)
            color = options[:color].downcase

            super({
              inline: true,
            }.merge(options))
          end

          def input_label(html, id)
            html.tag('label', class: 'form-check-label', for: id) do
              html.mtg.mtg_cost_icon(options[:color])
            end
          end
        end
      end
    end
  end
end
