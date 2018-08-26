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
      class LinkCardsTable < ::Html::Component
        def draw
          ::Html::Box.new(
            ::Html::Table.new(
              DeckCards::Columns::Name.new(sort: true),
              Cards::Columns::Cost.new(sort: true),
              Cards::Columns::CreatureStats.new(sort: true),
              Imports::Columns::Title.new(sort: true),
              ::Html::Table::Column.new(
                Forms::LinkCard.new(
                  icon: true,
                  inline: true,
                  source: :_current_row,
                  inline_values: true,
                ),
                title: 'Actions'
              ),
              source: :cards
            ),
            title: 'Link to cards you own'
          )
        end

        def render(html, context)
          if context[:count] > 0
            render_root(html, context)
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
