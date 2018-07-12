require_relative '../../components'

module Web
  module Views
    module FindDecks
      module Columns
        class OwnedDeckCount < Components::TableColumn
          title 'Owned'
          sort_column 'count'

          def render(html, context)
            card = context[:_current_row]
            owned = card[:owned_count].to_i
            required = card[:required_count].to_i
            percent = (owned * 100) / required

            html.tag('td') do
              cls = 'ml-1 badge'

              if owned >= required
                cls << ' badge-success'
              elsif owned
                cls << ' badge-warning'
              end
              html.tag('span', owned.to_s, class: 'ml-1 badge')
              html.tag('span', "#{percent}%", class: cls)
            end
          end
        end
      end
    end
  end
end
