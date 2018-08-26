module Web
  module Views
    module Cards
      module Forms
        class ColorFilter < ::Html::Form::Checkbox
          option :inline, true

          private

          def setup
            super

            @color = options[:color]
          end

          def input_label(html, id)
            html.tag('label', class: 'form-check-label', for: id) do
              html.mtg.mtg_cost_icon(@color)
            end
          end
        end
      end
    end
  end
end
