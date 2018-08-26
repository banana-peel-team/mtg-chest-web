module Web
  module Views
    module DeckCards
      class CardList < ::Html::Component
        def render(html, context)
          cards = context[options[:source]]
          html.tag('ul') do
            cards.each do |card|
              html.tag('li', "#{card[:count]} #{card[:card_name]}")
            end
          end
        end
      end
    end
  end
end
