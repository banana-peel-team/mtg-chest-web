require_relative '../../components/table_column'

module Web
  module Views
    module FindDecks
      module Columns
        class Name < Components::TableColumn
          title 'Deck'
          sort_column 'deck_name'

          def render(html, context)
            deck = context[:_current_row]

            html.tag('td') do
              html.link("/find-decks/#{deck[:deck_id]}", deck[:deck_name])

              if (count_column = options[:count])
                html.mtg.count_badge(deck[count_column].to_i)
              end
            end
          end
        end
      end
    end
  end
end
