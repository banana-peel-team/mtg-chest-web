module Web
  module Views
    module Cards
      module Columns
        class Score < ::Html::Table::Column
          option :title, 'Score'
          option :sort_column, 'score'

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
