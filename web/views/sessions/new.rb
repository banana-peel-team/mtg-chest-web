require_relative 'forms/new'

module Web
  module Views
    module Sessions
      class New < ::Html::Component
        def draw
          Layout.new(
            Forms::New.new(
              source: :user,
              namespace: 'signin',
            ),
            options
          )
        end
      end
    end
  end
end
