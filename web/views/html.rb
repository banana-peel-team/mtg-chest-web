require 'cgi'

require_relative 'extensions/form'
require_relative 'extensions/components'
require_relative 'extensions/icons'
require_relative 'extensions/pagination'
require_relative 'extensions/mtg'

module Web
  module Views
    class Html
      # FIXME: This is bullshit
      include Web::Views::Extensions::Form
      include Web::Views::Extensions::Components
      include Web::Views::Extensions::Icons
      include Web::Views::Extensions::Pagination
      include Web::Views::Extensions::MTG

      def initialize(options)
        @options = options

        @csrf_token = options[:csrf_token]
        @params = options[:params] || {}
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

      def params(override = nil)
        return @params unless override && override.any?

        @params.merge(override).reject { |k, v| !v }
      end

      def params_url(override)
        Rack::Utils.build_nested_query(params(override))
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
        append_html('<!DOCTYPE html><html>'.freeze)
        yield
        append_html('<html>'.freeze)
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

      def e(value)
        value = value.to_s unless value.is_a?(String)
        CGI.escapeHTML(value) if value
      end
    end
  end
end
