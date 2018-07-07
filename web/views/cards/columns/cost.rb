require_relative '../../components/table_column'

module Web
  module Views
    module Cards
      module Columns
        class Cost < Components::TableColumn
          title 'Cost'
          sort_column 'cmc'

          def render(html, context)
            card = context[:_current_row]

            html.tag('td') do
              html.mtg.card_cost(card)
            end
          end
        end
      end
    end
  end
end
