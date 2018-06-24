require_relative '../component'

module Web
  module Views
    module Components
      class Card < Component
        def render(html, context)
          html.simple_card(options[:title]) do
            super(html, context)
          end
        end
      end
    end
  end
end
