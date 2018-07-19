require_relative '../../components/table_column'

module Web
  module Views
    module Cards
      module Columns
        class Tags < Components::TableColumn
          title 'Tags'
          sort_column 'tags'

          def render(html, context)
            card = context[:_current_row]

            html.tag('td', class: 'mtgTags') do
              html.mtg.mtg_icons(card[:card_types])
              html.mtg.tags(card[:card_subtypes])
            end
          end
        end
      end
    end
  end
end
