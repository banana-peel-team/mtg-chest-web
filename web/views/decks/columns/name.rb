module Web
  module Views
    module Decks
      module Columns
        class Name < ::Html::Table::Column
          option :title, 'Deck'
          option :sort_column, 'deck_name'

          def render(html, context)
            deck = context[:_current_row]

            html.tag('td') do
              html.link("/decks/#{deck[:deck_id]}", deck[:deck_name])

              if (count_column = options[:count])
                html.mtg.count_badge(deck[count_column])
              end
            end
          end
        end
      end
    end
  end
end
