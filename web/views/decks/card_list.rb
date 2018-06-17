module Web
  module Views
    module Decks
      class CardList
        def initialize(attrs)
          @current_user = attrs[:current_user]
          @presenter = attrs[:presenter]
          @csrf_token = attrs[:csrf_token]
        end

        def render
          layout = Web::Views::Layout.new(
            current_user: @current_user,
            csrf_token: @csrf_token,
          )

          layout.render do |html|
            breadcrumb(html)

            body(html)
          end
        end

        def body(html)
          html.tag('h2', 'Card list')
          html.tag('ul') do
            @presenter.cards.each do |card|
              html.tag('li') do
                html.append_html(
                  "#{card[:count]} #{card[:card_name]}"
                )
              end
            end
          end
        end

        def breadcrumb(html)
          html.breadcrumb do
            html.breadcrumb_item do
              html.link('/decks', 'Decks')
            end

            html.breadcrumb_item do
              html.link(
                "/decks/#{@presenter.deck[:id]}",
                @presenter.deck[:name]
              )
            end

            html.breadcrumb_item('Card list')
          end
        end
      end
    end
  end
end
