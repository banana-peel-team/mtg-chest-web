module Web
  module Views
    class Html
      def initialize(options)
        @csrf_token = options[:csrf_token]
        @buffer = ''
      end

      def self.render(options = {}, &block)
        html = new(options)

        block.call(html)

        html.out
      end

      def out
        @buffer
      end

      def append_html(content)
        @buffer << content if content

        # failsafe for code trying to return the the value from append
        nil
      end

      def append_text(content)
        append_html(e(content))
      end

      def meta(attrs)
        stag('meta', attrs)
      end

      def html5
        append_html('<!DOCTYPE html><html>')
        yield
        append_html('<html>')
      end

      def form(attrs)
        attrs = { method: 'post' }.merge(attrs)

        tag('form', attrs) do
          if attrs[:method] != 'get' && !@csrf_token.empty?
            input_hidden('csrf_token', @csrf_token)
          end

          yield
        end
      end

      def delete_form(opts, &block)
        form(opts) do
          input_hidden('_method', 'delete') if opts[:method] != 'get'

          block.call
        end
      end

      def input_hidden(name, value)
        append_html(
          %Q(<input type="hidden" name="#{name}" value="#{e(value)}">)
        )
      end

      def tag(name, content = nil, attrs = nil)
        if content.is_a?(Hash)
          attrs = content
          content = nil
        end

        attrs &&= build_attrs(attrs)

        append_html("<#{name}#{attrs}>")

        if content
          append_text(content)
        elsif block_given?
          yield
        end

        append_html("</#{name}>")
      end

      def stag(name, attrs = nil)
        attrs &&= build_attrs(attrs)

        append_html("<#{name}#{attrs} />")
      end

      def build_attrs(attrs)
        attrs.map do |k, v|
          next unless v
          next " #{k}" if v == true

          " #{k}=\"#{e(v)}\""
        end.join
      end

      ## Bootstrap / Font Awesome

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

      def submit(text)
        stag('input', class: 'btn btn-primary', type: 'submit', value: e(text))
      end

      def textarea(attrs)
        form_group do
          tag('textarea', attrs.merge(class: 'form-control'))
        end
      end

      def form_group(&block)
        tag('div', class: 'form-group', &block)
      end

      def icon(name, attrs = {})
        cls = "fas fa-#{name}"
        cls << ' icon-danger' if attrs[:style] == 'danger'

        tag('i', class: cls)
      end

      def icon_button(name, title, attrs = {})
        attrs = attrs.dup
        cls = 'form-control btn btn-sm'

        case attrs.delete(:style)
        when 'danger'
          cls << ' btn-outline-danger'
        end

        attrs.merge!(
          class: cls,
          type: 'submit',
          title: title,
        )

        tag('button', attrs) do
          icon(name)
        end
      end

      def icon_link(path, name, alt)
        append_html(
          %Q(<a href="#{path}" title="#{alt}"><i class="fas fa-#{name}">) +
          %Q(<span class="alt-text">#{alt}</span></i></a>)
        )
      end

      def delete_button
        icon_button('trash-alt', 'Delete', style: 'danger')
      end

      def breadcrumb_item(content = false, &block)
        cls = 'breadcrumb-item'
        cls << ' active' if content

        tag('li', content, class: cls, &block)
      end

      def breadcrumb(&block)
        tag('nav', 'aria-label': 'breadcrumb') do
          tag('ol', class: 'breadcrumb', &block)
        end
      end

      def striped_table(&block)
        cls = 'table table-striped table-sm table-hover mt-5'
        tag('table', class: cls, &block)
      end

      def link(path, content, attrs = {}, &block)
        attrs = {href: path}.merge(attrs)
        tag('a', content, attrs, &block)
      end

      def e(value)
        value = value.to_s unless value.is_a?(String)
        CGI.escapeHTML(value) if value
      end
    end
  end
end
