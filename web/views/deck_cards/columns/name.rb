module Web
  module Views
    module DeckCards
      module Columns
        class Name < ::Html::Table::Column
          option :title, 'Name'
          option :sort_column, 'card_name'

          def render(html, context)
            card = context[:_current_row]

            html.tag('td') do
              html.mtg.printing_icon(card)

              html.append_html(card[:card_name])

              if @count
                count = card[:collection_count] || card[:card_count]
                if count && count > 0
                  html.mtg.count_badge(count, options[:force_count])
                end
              end

              if card[:is_flagged]
                html.append_html(' ')
                html.icons.icon('flag', style: 'danger')
              end

              html.mtg.card_text(card)
            end
          end

          private

          def setup
            super

            @count = options.fetch(:count) { true }
          end
        end
      end
    end
  end
end
