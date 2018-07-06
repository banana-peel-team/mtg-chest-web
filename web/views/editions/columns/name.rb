require_relative '../../components/table_column'

module Web
  module Views
    module Editions
      module Columns
        class Name < Components::TableColumn
          def render(html, context)
            edition = context[:_current_row]

            html.tag('td') do
              html.link("/editions/#{edition[:code]}", edition[:name])
            end
          end
        end
      end
    end
  end
end
