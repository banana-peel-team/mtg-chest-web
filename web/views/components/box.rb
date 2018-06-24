require_relative '../component'

module Web
  module Views
    module Components
      class Box < Component
        def render(html, context)
          html.box do
            if options[:title]
              html.box_title(options[:title])
            end
            super(html, context)
          end
        end
      end
    end
  end
end
