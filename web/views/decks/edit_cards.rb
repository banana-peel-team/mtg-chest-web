require_relative 'show'

module Web
  module Views
    module Decks
      class EditCards < Web::Views::Decks::Show
        def body(html)
          html.box do
            html.box_title do
              html.append_html('Deck cards')
              html.mtg.count_badge(@presenter.deck[:card_count])
            end

            cards_list(html, @presenter.cards)
          end

          if (count = @presenter.scratchpad.count) > 0
            html.box do
              html.box_title do
                html.append_html('Scratchpad')
                html.mtg.count_badge(count, true)
              end

              cards_list(html, @presenter.scratchpad) do |card|
                scratchpad_actions(html, card)
              end
            end
          end
        end

        def card_name_cell(html, card)
          html.tag('td') do
            html.mtg.printing_icon(card)

            html.append_html(card[:card_name])

            if card[:is_flagged]
              html.append_html(' ')
              html.icons.icon('flag', style: 'danger')
            end

            html.mtg.count_badge(card[:count])
            html.mtg.card_text(card)
          end
        end

        def actions(html, card)
          path = "/deck-cards/#{card[:deck_card_id]}"
          html.form(action: path) do |form|
            form.button_group do
              unless card[:is_flagged]
                form.button('Flag for removal', 'status', 'flagged', {
                  icon: 'flag', style: :light, small: true
                })
              end

              if card[:user_printing_id]
                path = "/deck-cards/#{card[:deck_card_id]}/unlink"
                form.button('Unlink', 'status', 'unlinked', {
                  icon: 'unlink', style: :light, small: true
                })
              end

              form.button('Unlink', 'status', 'removed', {
                icon: 'trash-alt', style: :danger, small: true
              })
            end
          end
        end

        def scratchpad_actions(html, card)
          path = "/deck-cards/#{card[:deck_card_id]}"
          html.form(action: path) do |form|
            form.button_group do
              form.button('Move to deck', 'slot', 'deck', {
                icon: 'plus', style: :light, small: true
              })

              form.button('Unlink', 'status', 'removed', {
                icon: 'trash-alt', style: :danger, small: true
              })
            end
          end
        end

        def breadcrumb(html)
          html.tag('div', class: 'row') do
            html.tag('div', class: 'col-9') do
              html.breadcrumb do
                html.breadcrumb_item do
                  html.link('/decks', 'Decks')
                end

                html.breadcrumb_item do
                  deck_path = "/decks/#{@presenter.deck[:id]}"
                  html.link(deck_path, @presenter.deck[:name])
                end
                html.breadcrumb_item('Edit')
              end
            end

            html.tag('div', class: 'col') do
              html.tag('ul', class: 'nav justify-content-end') do
                html.tag('li', class: 'nav-item mr-4') do
                  path = "/decks/#{@presenter.deck[:id]}/add-cards"
                  html.link(path, 'Add cards', class: 'nav-link btn btn-light')
                end

                html.tag('li', class: 'nav-item mr-3') do
                  path = "/decks/#{@presenter.deck[:id]}/link"
                  html.link(
                    path, 'Link cards', class: 'nav-link btn btn-light'
                  )
                end
              end
            end
          end
        end
      end
    end
  end
end
