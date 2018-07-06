module Web
  module Views
    module Extensions
      module Components
        def box(&block)
          #tag('div', class: 'bg-white p-3 mb-3', &block)
          tag('div', class: 'card border-light p-3 mb-3', &block)
        end

        def box_title(text = nil, &block)
          tag('h3', text, class: 'card-title', &block)
        end

        def simple_card(title, options = {})
          cls = 'card mt-3'
          cls << ' border-success' if options[:type] == :success
          cls << ' border-warning' if options[:type] == :warning

          tag('div', class: cls) do
            tag('div', title, class: 'card-header')

            body_cls = 'card-body'
            #body_cls << ' text-success'  if options[:type] == :success
            #body_cls << ' text-warning'  if options[:type] == :warning

            tag('div', class: body_cls) do
              yield
            end
          end
        end

        #def submit(text)
          #stag('input', class: 'btn btn-primary', type: 'submit', value: e(text))
        #end

        def navigation_item(content = false, &block)
          cls = 'navigation-item'
          cls << ' active' if content

          tag('li', content, class: cls, &block)
        end

        def navigation(&block)
          tag('nav', 'aria-label': 'navigation') do
            tag('ol', class: 'navigation', &block)
          end
        end

        def striped_table(&block)
          cls = 'table table-striped table-sm table-hover mt-2'
          tag('table', class: cls, &block)
        end

        def link(path, content, attrs = {}, &block)
          attrs = {href: path}.merge(attrs)
          tag('a', content, attrs, &block)
        end

        def link_current(params, content = nil, attrs = {}, &block)
          attrs = {href: '?' + params_url(params)}.merge(attrs)

          tag('a', content, attrs, &block)
        end
      end
    end
  end
end
