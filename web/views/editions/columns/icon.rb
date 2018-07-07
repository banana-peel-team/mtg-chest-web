require_relative '../../components/table_column'

module Web
  module Views
    module Editions
      module Columns
        class Icon < Components::TableColumn
          title 'Set Icon'

          def render(html, context)
            edition = context[:_current_row]
            html.tag('td') do
              html.mtg.edition_icon(edition)
            end
          end
        end
      end
    end
  end
end
