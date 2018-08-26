require_relative 'link_cards_table'
require_relative 'forms/link_card'
require_relative 'navigation/list'
require_relative 'navigation/show'
require_relative 'navigation/edit'
require_relative 'navigation/link_cards'
require_relative '../imports/columns/title'

module Web
  module Views
    module Decks
      class LinkCards < ::Html::Component
        def draw
          Layout.new(
            ::Html::Navigation.new(
              Navigation::List.new(breadcrumb: true),
              Navigation::Show.new(breadcrumb: true, deck: :deck),
              Navigation::Edit.new(breadcrumb: true, deck: :deck),
              Navigation::LinkCards.new(
                breadcrumb: true, deck: :deck, current: true
              ),
              breadcrumb: true
            ),
            LinkCardsTable.new,
          )
        end
      end
    end
  end
end
