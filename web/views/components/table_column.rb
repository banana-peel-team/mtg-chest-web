require_relative '../component'

module Web
  module Views
    module Components
      class TableColumn < Component
        def initialize(name, elements = [], options = {})
          super(elements, options)

          @name = name
        end

        def header(html, context)
          if (sort = options[:sort])
            sorting = context[:_current_table][:sorting] || {}

            html.tag('th') do
              sort_link(html, sorting, sort, @name)
            end
          else
            html.tag('th', @name)
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
            html.tag('td', value.strftime('%F %I:%M%P'))
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
