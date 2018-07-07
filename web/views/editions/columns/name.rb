require_relative '../../components/table_column'

module Web
  module Views
    module Editions
      module Columns
        class Name < Components::TableColumn
          title 'Edition'
          sort_column 'edition_name'

          def render(html, context)
            edition = context[:_current_row]

            html.tag('td') do
              html.link(
                "/editions/#{edition[:edition_code]}", edition[:edition_name]
              )
            end
          end
        end
      end
    end
  end
end
