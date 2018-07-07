require_relative '../components/box'
require_relative '../components/navigation'
require_relative '../components/table'
require_relative '../components/box_title'

require_relative '../cards/columns/score'
require_relative '../cards/columns/tags'
require_relative '../cards/columns/cost'
require_relative '../cards/columns/identity'
require_relative '../cards/columns/creature_stats'
require_relative '../deck_cards/columns/name'

require_relative 'navigation/list'
require_relative 'navigation/show'
require_relative 'navigation/card_list'
require_relative 'navigation/export_deckbox'

module Web
  module Views
    module Imports
      Show = Layout.new([
        Components::Navigation.new([
          Navigation::List.new(breadcrumb: true),
          Navigation::Show.new(
            import: :import, breadcrumb: true, current: true
          ),
        ], breadcrumb: true),

        Components::Box.new([
          Components::BoxTitle.new(
            source: :import, title: :title, count: :user_printing_count
          ),
          Components::Navigation.new([
            Navigation::CardList.new(import: :import),
            Navigation::ExportDeckbox.new(import: :import),
          ]),
          Components::Table.new([
            Cards::Columns::Score.new('Score', sort: 'score'),
            DeckCards::Columns::Name.new('Name', sort: 'name'),
            Cards::Columns::Tags.new('Tags'),
            Cards::Columns::Cost.new('Cost', sort: 'cmc'),
            Cards::Columns::Identity.new('Identity', sort: 'identity'),
            Cards::Columns::CreatureStats.new('P/T', sort: true),
          ], source: :printings),
        ]),
      ])
    end
  end
end
