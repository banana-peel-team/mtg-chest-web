require_relative '../../components/table_column'

module Web
  module Views
    module FindDecks
      module Columns
        class OwnedCount < Components::TableColumn
          title 'Owned'
          sort_column 'owned'

          def render(html, context)
            card = context[:_current_row]
            count = card[:in_collection] || 0
            required = card[:count] || 0

            html.tag('td') do
              cls = 'ml-1 badge'

              if count >= required
                cls << ' badge-success'
              elsif count > 0
                cls << ' badge-warning'
              else
                cls << ' badge-danger'
              end
              html.tag('span', count.to_s, class: cls)
            end
          end
        end
      end
    end
  end
end
