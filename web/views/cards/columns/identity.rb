module Web
  module Views
    module Cards
      module Columns
        class Identity < ::Html::Table::Column
          option :title, 'Identity'
          option :sort_column, 'identity'

          def render(html, context)
            card = context[:_current_row]

            html.tag('td') do
              html.mtg.icons_list(card[:card_color_identity])
            end
          end
        end
      end
    end
  end
end
