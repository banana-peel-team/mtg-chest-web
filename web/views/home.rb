require_relative 'layout'

module Web
  module Views
    class Home < ::Html::Component
      def draw
        Layout.new
      end
    end
  end
end
