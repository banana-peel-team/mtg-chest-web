module Web
  module Views
    class Home
      def initialize(attrs)
        @current_user = attrs[:current_user]
        @presenter = attrs[:presenter]
        @csrf_token = attrs[:csrf_token]
      end

      def render
        layout = Web::Views::Layout.new(
          current_user: @current_user,
          csrf_token: @csrf_token,
        )

        layout.render do |html|
          html.tag('h2', 'Home')
        end
      end
    end
  end
end
