require_relative 'navigation/list'
require_relative 'navigation/new'
require_relative 'forms/new_from_list'
require_relative 'forms/new_from_file'

module Web
  module Views
    module Imports
      class New < ::Html::Component
        def draw
          Layout.new(
            ::Html::Navigation.new(
              Navigation::List.new(breadcrumb: true),
              Navigation::New.new(breadcrumb: true, current: true),
              breadcrumb: true
            ),
            ::Html::Box.new(
              ::Html::Card.new(
                Forms::NewFromList.new(namespace: 'import'),
                title: 'From list'
              ),
              ::Html::Card.new(
                Forms::NewFromFile.new(namespace: 'import'),
                title: 'From file'
              ),
              title: 'Import cards'
            )
          )
        end
      end
    end
  end
end
