require_relative '../components/table_column'

module Web
  module Views
    module Imports
      class ActionsColumn < Components::TableColumn
        def render(html, import, _context)
          html.tag('td') do
            html.delete_form(action: "/collection/imports/#{import[:id]}") do
              html.icons.delete_button
            end
          end
        end
      end
    end
  end
end
