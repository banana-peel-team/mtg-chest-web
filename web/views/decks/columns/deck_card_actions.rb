require_relative '../../components/table_column'

module Web
  module Views
    module Decks
      module Columns
        class DeckCardActions < Components::TableColumn
          title 'Actions'

          def render(html, context)
            card = context[:_current_row]

            html.tag('td') do
              base = "/decks/#{context[:deck][:id]}/cards/#{card[:card_id]}"

              html.icons.icon_link(
                base + "/alternatives", 'exchange-alt', 'Alternatives'
              )
              html.append_html(' ')
              html.icons.icon_link(base + "/synergy", 'trophy', 'Synergy')
            end
          end
        end
      end
    end
  end
end
