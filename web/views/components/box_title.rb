require_relative '../component'

module Web
  module Views
    module Components
      class BoxTitle < Component
        def render(html, context)
          source = context[options[:source]]
          return unless source

          title = from_source(source)

          html.box_title do
            html.append_text(title)
            if (count = options[:count])
              html.mtg.count_badge(source[count], options[:force_count])
            end

            super(html, context)
          end
        end

        private

        def from_source(source)
          if (title = options[:title])
            source[title]
          else
            source
          end
        end
      end
    end
  end
end
