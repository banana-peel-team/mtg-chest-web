module Web
  module Views
    module FindDecks
      module Columns
        class OwnedDeckCount < ::Html::Table::Column
          option :title, 'Owned'
          option :sort_column, 'count'

          def render(html, context)
            card = context[:_current_row]
            owned = card[:owned_count].to_i
            required = card[:card_count].to_i
            percent = (owned * 100) / required

            html.tag('td') do
              cls = 'ml-1 badge'

              if owned >= required
                cls << ' badge-success'
              elsif owned
                cls << ' badge-warning'
              end
              html.tag('span', "#{percent}%", class: cls)
              html.tag(
                'span', "(#{required - owned} missing)", class: 'ml-1 badge'
              )
            end
          end
        end
      end
    end
  end
end
