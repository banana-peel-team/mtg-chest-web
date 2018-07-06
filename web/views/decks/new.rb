require_relative '../components/navigation'

require_relative 'navigation/list'
require_relative 'navigation/new'
require_relative 'forms/new'

module Web
  module Views
    module Decks
      New = Layout.new([
        Components::Navigation.new([
          Navigation::List.new(breadcrumb: true),
          Navigation::New.new(breadcrumb: true, current: true),
        ], breadcrumb: true),
        Components::Box.new([
          Forms::New.new(name: 'deck'),
        ], title: 'Create deck'),
      ])
    end
  end
end
