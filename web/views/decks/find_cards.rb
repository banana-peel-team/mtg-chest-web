require_relative 'show'
module Web
  module Views
    module Decks
      class FindCards < Web::Views::Decks::Show
        def body(html)
          html.box do
            html.box_title('Suggested cards')

            html.form(method: 'get') do |form|
              form.checkbox(:all, label: 'Show all', value: '1', inline: true)
              form.submit('Refresh')
            end

            cards_list(html, @presenter.paginated)
          end

          html.box do
            html.pagination(@presenter.current_page, @presenter.total_pages)
          end
        end

        def actions(html, card)
          add_card_to_deck(html, @presenter.deck, card) do |form|
            form.button_group do
              form.button('Add to deck', 'slot', 'deck', {
                icon: 'plus', style: :light, small: true
              })
              form.button('Add to scratchpad', 'slot', 'scratchpad', {
                icon: 'pencil-alt', style: :light, small: true
              })
              form.button('Ignore this card', 'slot', 'ignored', {
                icon: 'thumbs-down', style: :light, small: true
              })
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
                "/decks/#{@presenter.deck[:id]}", @presenter.deck[:name]
              )
            end
            html.breadcrumb_item('Find cards')
          end
        end
      end
    end
  end
end
