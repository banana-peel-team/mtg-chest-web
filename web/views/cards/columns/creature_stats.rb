require_relative '../../components/table_column'

module Web
  module Views
    module Cards
      module Columns
        class CreatureStats < Components::TableColumn
          def render(html, _context)
            card = _context[:_current_row]

            if card[:power]
              html.tag('td', "#{card[:power]}/#{card[:toughness]}")
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
