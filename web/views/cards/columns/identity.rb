require_relative '../../components/table_column'

module Web
  module Views
    module Cards
      module Columns
        class Identity < Components::TableColumn
          title 'Identity'
          sort_column 'identity'

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
