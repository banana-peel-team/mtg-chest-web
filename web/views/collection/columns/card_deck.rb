require_relative '../../components/table_column'

module Web
  module Views
    module Collection
      module Columns
        class CardDeck < Components::TableColumn
          def render(html, context)
            card = context[:_current_row]

            html.tag('td') do
              if card[:deck_id]
                html.link("/decks/#{card[:deck_id]}", card[:deck_name])
              end
            end
          end
        end
      end
    end
  end
end
