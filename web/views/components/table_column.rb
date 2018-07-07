require_relative '../component'

module Web
  module Views
    module Components
      class TableColumn < Component
        def self.title(title)
          options[:title] = title
        end

        def self.sort_column(column)
          options[:sort_column] = column
        end

        def header(html, context)
          if options[:sort]
            sort = options[:sort_column]
            sorting = context[:_current_table][:sorting] || {}

            html.tag('th') do
              sort_link(html, sorting, sort, options[:title])
            end
          else
            html.tag('th', options[:title])
          end
        end

        def render(html, context)
          if elements
            return html.tag('td') do
              super(html, context)
            end
          end

          row = context[:_current_row]
          value = row[options[:source]]

          case value
          when DateTime, Time
            html.tag('td', value.strftime(options[:format] || '%F %I:%M%P'))
          else
            if value
              html.tag('td', value)
            else
              html.tag('td', 'N/A')
            end
          end
        end

        private

        def sort_link(html, sorting, name, text)
          params = { 'sort' => name, 'page' => nil, 'dir' => 'desc' }

          unless name == sorting[:column]
            return html.link_current(params, text)
          end

          params['dir'] = 'asc' if sorting[:direction] == 'desc'

          html.link_current(params, text)

          if params['dir'] == 'asc'
            html.icons.icon('angle-up', class: 'ml-1')
          else
            html.icons.icon('angle-down', class: 'ml-1')
          end
        end
      end
    end
  end
end
