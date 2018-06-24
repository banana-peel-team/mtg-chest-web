require_relative '../../components/table_column'

module Web
  module Views
    module Collection
      module Columns
        class CardImport < Components::TableColumn
          def render(html, context)
            card = context[:_current_row]

            html.tag('td') do
              html.link(
                "/collection/imports/#{card[:import_id]}",
                card[:import_title]
              )
            end
          end
        end
      end
    end
  end
end
