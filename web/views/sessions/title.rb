module Web
  module Views
    module Sessions
      class Title
        def initialize(title)
          @title = title
        end

        def render(html, context)
          html.tag('h2', @title)
        end
      end
    end
  end
end
