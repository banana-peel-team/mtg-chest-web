require_relative '../components/navigation'
require_relative '../components/card'

require_relative 'navigation/list'
require_relative 'navigation/new'
require_relative 'forms/new_from_list'
require_relative 'forms/new_from_file'

module Web
  module Views
    module Imports
      New = Layout.new([
        Components::Navigation.new([
          Navigation::List.new(breadcrumb: true),
          Navigation::New.new(breadcrumb: true, current: true),
        ], breadcrumb: true),
        Components::Box.new([
          Components::Card.new([
            Forms::NewFromList.new(name: 'import'),
          ], title: 'From list'),
          Components::Card.new([
            Forms::NewFromFile.new(name: 'import'),
          ], title: 'From file'),
        ], title: 'Import cards')
      ])
    end
  end
end
