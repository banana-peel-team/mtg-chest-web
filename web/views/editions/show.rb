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
require_relative '../deck_cards/columns/name'
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
          Components::Form.new([
            Cards::Forms::IdentityFilter.new(
              name: 'filter',
              source: :printings,
            ),
            Components::Forms::Submit.new(label: 'Refresh'),
          ], method: 'get'),
          Components::Table.new([
            Cards::Columns::Score.new(sort: true),
            DeckCards::Columns::Name.new(sort: true),
            Cards::Columns::Tags.new,
            Cards::Columns::Cost.new(sort: true),
            Cards::Columns::Identity.new(sort: true),
            Cards::Columns::CreatureStats.new(sort: true),
          ], source: :printings)
        ])
      ])
    end
  end
end
