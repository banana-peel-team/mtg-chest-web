module Web
  module Views
    module Cards
      module Columns
        class CreatureStats < ::Html::Table::Column
          def render(html, _context)
            card = _context[:_current_row]

            if card[:card_power]
              html.tag('td', "#{card[:card_power]}/#{card[:card_toughness]}")
            else
              html.tag('td')
            end
          end

          private

          def sort_link(html, sorting, sort, text)
            super(html, sorting, 'power', 'P')
            html.append_html('/')
            super(html, sorting, 'toughness', 'T')
          end
        end
      end
    end
  end
end
