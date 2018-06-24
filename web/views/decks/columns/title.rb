require_relative '../../components/table_column'

module Web
  module Views
    module Decks
      module Columns
        class Title < Components::TableColumn
          def render(html, context)
            deck = context[:_current_row]

            html.tag('td') do
              html.link("/decks/#{deck[:id]}", deck[:name])
              html.mtg.count_badge(deck[:card_count])
            end
          end
        end
      end
    end
  end
end
