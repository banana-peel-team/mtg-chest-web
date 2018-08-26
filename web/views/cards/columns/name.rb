module Web
  module Views
    module Cards
      module Columns
        class Name < ::Html::Table::Column
          option :title, 'Name'
          option :sort_column, 'card_name'

          def render(html, context)
            card = context[:_current_row]

            html.tag('td') do
              html.append_html(card[:card_name])
            end
          end
        end
      end
    end
  end
end
