require_relative '../components/table'
require_relative '../components/table_column'
require_relative '../components/navigation'
require_relative '../components/box'
require_relative '../components/box_title'

require_relative '../cards/columns/score'
require_relative '../cards/columns/tags'
require_relative '../cards/columns/cost'
require_relative '../cards/columns/identity'
require_relative '../cards/columns/creature_stats'
require_relative '../deck_cards/columns/title'
require_relative 'navigation/list'
require_relative 'navigation/show'

module Web
  module Views
    module Editions
      Show = Layout.new([
        Components::Navigation.new([
          Navigation::List.new(breadcrumb: true),
          Navigation::Show.new(
            breadcrumb: true, edition: :edition, current: true
          ),
        ], breadcrumb: true),
        Components::Box.new([
          Components::BoxTitle.new(source: :edition, title: :name),
          Components::Table.new([
            Cards::Columns::Score.new('Score', sort: 'score'),
            DeckCards::Columns::Title.new('Name', sort: 'name'),
            Cards::Columns::Tags.new('Tags'),
            Cards::Columns::Cost.new('Cost', sort: 'cmc'),
            Cards::Columns::Identity.new('Identity', sort: 'identity'),
            Cards::Columns::CreatureStats.new('P/T', sort: true),
          ], source: :printings)
        ])
      ])
    end
  end
end
