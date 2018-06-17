require_relative 'show'

module Web
  module Views
    module Decks
      class EditCards < Web::Views::Decks::Show
        def body(html)
          html.tag('h2') do
            html.append_html('Deck cards')
            Helpers.count_badge(html, @presenter.deck[:card_count])
          end

          cards_list(html, @presenter.cards)

          if (count = @presenter.scratchpad.count) > 0
            html.tag('h2') do
              html.append_html('Scratchpad')
              Helpers.count_badge(html, count, true)
            end
            cards_list(html, @presenter.scratchpad) do |card|
              scratchpad_actions(html, card)
            end
          end
        end

        def actions(html, card)
          if card[:user_printing_id]
            path = "/deck-cards/#{card[:deck_card_id]}/unlink"

            html.delete_form(action: path, class: 'form-inline') do
              button_attrs = {
                class: 'form-control btn',
                type: 'submit',
                name: 'slot',
              }

              html.tag('button',
                      button_attrs.merge(value: 'deck', title: 'Deck')) do
                html.icon('unlink')
              end
            end
          end

          delete_card(html, card)
        end

        def scratchpad_actions(html, card)
          add_card_to_deck(html, @presenter.deck, card) do
            button_attrs = {
              class: 'form-control btn',
              type: 'submit',
              name: 'slot',
            }

            html.tag('button',
                     button_attrs.merge(value: 'deck', title: 'Deck')) do
              html.icon('plus')
            end
          end

          path = "/decks/#{@presenter.deck[:id]}/cards/#{card[:deck_card_id]}"

          html.delete_form(action: path, class: 'form-inline') do
            html.delete_button
          end
        end

        def breadcrumb(html)
          html.tag('div', class: 'row') do
            html.tag('div', class: 'col-9') do
              html.breadcrumb do
                html.breadcrumb_item do
                  html.tag('a', 'Decks', href: '/decks')
                end

                html.breadcrumb_item do
                  deck_path = "/decks/#{@presenter.deck[:id]}"
                  html.tag('a', @presenter.deck[:name], href: deck_path)
                end
                html.breadcrumb_item('Edit')
              end
            end

            html.tag('div', class: 'col') do
              html.tag('ul', class: 'nav justify-content-end') do
                html.tag('li', class: 'nav-item mr-4') do
                  path = "/decks/#{@presenter.deck[:id]}/add-cards"
                  html.tag('a', class: 'nav-link btn btn-light', href: path) do
                    html.append_html('Add cards')
                  end
                end

                html.tag('li', class: 'nav-item mr-3') do
                  path = "/decks/#{@presenter.deck[:id]}/link"
                  html.tag('a', class: 'nav-link btn btn-light', href: path) do
                    html.append_html('Link cards')
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
