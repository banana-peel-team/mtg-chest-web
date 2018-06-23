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

        def card_name_cell(html, card)
          html.tag('td') do
            Helpers.printing_symbol(html, card)

            html.append_html(card[:card_name])

            if card[:is_flagged]
              html.append_html(' ')
              html.icon('flag', style: 'danger')
            end

            Helpers.count_badge(html, card[:count])
            Helpers.card_text(html, card)
          end
        end

        def actions(html, card)
          unless card[:is_flagged]
            path = "/deck-cards/#{card[:deck_card_id]}/flag"

            html.form(action: path, class: 'form-inline') do
              html.input_hidden('card_id', card[:card_id])
              html.icon_button('flag', 'Flag for removal')
            end
          end

          if card[:user_printing_id]
            path = "/deck-cards/#{card[:deck_card_id]}/unlink"

            html.delete_form(action: path, class: 'form-inline') do
              html.icon_button('unlink', 'Unlink')
            end
          end

          delete_card(html, card)
        end

        def scratchpad_actions(html, card)
          add_card_to_deck(html, @presenter.deck, card) do
            html.icon_button('plus', 'Deck', name: 'slot', value: 'deck')
          end

          delete_card(html, card)
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
