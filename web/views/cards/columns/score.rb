require_relative '../../components/table_column'

module Web
  module Views
    module Cards
      module Columns
        class Score < Components::TableColumn
          title 'Score'
          sort_column 'score'

          def render(html, context)
            card = context[:_current_row]

            html.tag('td') do
              html.mtg.card_score(context[:rated_decks], card)
            end
          end
        end
      end
    end
  end
end
