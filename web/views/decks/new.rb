require_relative 'navigation/list'
require_relative 'navigation/new'
require_relative 'forms/new'

module Web
  module Views
    module Decks
      class New < ::Html::Component
        def draw
          Layout.new(
            ::Html::Navigation.new(
              Navigation::List.new(breadcrumb: true),
              Navigation::New.new(breadcrumb: true, current: true),
              breadcrumb: true
            ),
            ::Html::Box.new(
              Forms::New.new(namespace: 'deck'),
              title: 'Create deck'
            ),
          )
        end
      end
    end
  end
end
