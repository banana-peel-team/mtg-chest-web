require_relative '../component'

module Web
  module Views
    module Components
      class Table < Component
        def render(html, context)
          source = context[options[:source]]
          data = source[:list]
          rows = source[:paginated] ? data[:items] : data

          context = context.merge(_current_table: source)

          html.striped_table do
            html.tag('thead') do
              html.tag('tr') do
                elements.each { |column| column.header(html, context) }
              end
            end

            html.tag('tbody') do
              rows.each do |row|
                context = context.merge(_current_row: row)
                html.tag('tr') do
                  elements.each do |column|
                    column.render(html, context)
                  end
                end
              end
            end
          end

          if source[:paginated]
            html.pagination(data)
          end
        end
      end
    end
  end
end
