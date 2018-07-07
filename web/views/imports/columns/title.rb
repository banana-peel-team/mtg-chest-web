require_relative '../../components/table_column'

module Web
  module Views
    module Imports
      module Columns
        class Title < Components::TableColumn
          title 'Import'
          sort_column 'import_name'

          def render(html, context)
            import = context[:_current_row]

            html.tag('td') do
              html.link(
                "/collection/imports/#{import[:import_id]}",
                import[:import_title]
              )
              html.mtg.count_badge(import[:import_cards_count])
            end
          end
        end
      end
    end
  end
end
