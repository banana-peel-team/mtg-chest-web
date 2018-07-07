require_relative '../components/table'
require_relative '../components/navigation'

require_relative 'forms/link_card'
require_relative 'navigation/list'
require_relative 'navigation/show'
require_relative 'navigation/edit'
require_relative 'navigation/link_cards'
require_relative '../imports/columns/title'
require_relative '../deck_cards/columns/name'
require_relative '../cards/columns/cost'
require_relative '../cards/columns/creature_stats'

module Web
  module Views
    module Decks
      class LinkCardsTable < Component
        Table = Components::Box.new([
          Components::Table.new([
            DeckCards::Columns::Name.new(sort: true),
            Cards::Columns::Cost.new(sort: true),
            Cards::Columns::CreatureStats.new(sort: true),
            Imports::Columns::Title.new(sort: true),
            Components::TableColumn.new([
              Forms::LinkCard.new({
                icon: true, inline: true, source: :_current_row
              }),
            ], title: 'Actions'),
          ], source: :cards),
        ], title: 'Link to owned cards')

        def render(html, context)
          if context[:count] > 0
            Table.render(html, context)
          else
            if context[:total_missing] > 0
              html.simple_card('Missing cards', type: :warning) do
                html.append_text(
                  %Q(This deck contains cards that you don't own)
                )
              end
            else
              html.simple_card('All done', type: :success) do
                html.append_html('All deck cards are linked')
              end
            end
          end
        end
      end
    end
  end
end
