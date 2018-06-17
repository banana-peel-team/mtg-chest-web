module Web
  module Views
    module Collection
      class Show
        CARDS_LIST_HEADER = Html.render do |html|
          html.tag('thead') do
            html.tag('tr') do
              html.tag('th', 'Score')
              html.tag('th', 'Name')
              html.tag('th', 'Tags')
              html.tag('th', 'Cost')
              html.tag('th', 'Identity')
              html.tag('th', 'P/T')
              html.tag('th', 'Deck')
              html.tag('th', 'Import')
            end
          end
        end.freeze

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
          html.tag('h2') do
            html.append_html('My collection')
            Helpers.count_badge(html, @presenter.card_count)
          end
          cards_list(html, @presenter.paginated)
          Helpers.pagination(
            html, @presenter.current_page, @presenter.total_pages
          )
        end

        def cards_list(html, cards, &block)
          html.striped_table do
            html.append_html(CARDS_LIST_HEADER)

            html.tag('tbody') do
              cards.each do |card|
                html.tag('tr') do
                  html.tag('td') do
                    Helpers.card_score(html, @presenter.rated_decks, card)
                  end
                  html.tag('td') do
                    Helpers.printing_symbol(html, card)
                    html.tag('span', card[:card_name])
                    Helpers.count_badge(html, card[:count])
                    Helpers.card_text(html, card)
                  end
                  html.tag('td', class: 'mtgTags') do
                    card[:types].each do |type|
                      html.tag('i', title: type,
                                    class: "ms ms-#{type.downcase}")
                      html.append_html(' ')
                    end

                    Helpers.mtg_tags(html, card[:subtypes])
                  end
                  html.tag('td') do
                    html.append_html(Helpers.mtg_icons(card[:mana_cost]))
                  end

                  html.tag('td') do
                    html.append_html(
                      Helpers.mtg_icons_list(card[:color_identity])
                    )
                  end

                  if card[:power]
                    html.tag('td', "#{card[:power]}/#{card[:toughness]}")
                  else
                    html.tag('td')
                  end

                  html.tag('td') do
                    if card[:deck_id]
                      html.link(
                        "/decks/#{card[:deck_id]}",
                        card[:deck_name]
                      )
                    end
                  end

                  html.tag('td') do
                    html.link(
                      "/collection/imports/#{card[:import_id]}",
                      card[:import_title]
                    )
                  end
                end
              end
            end
          end
        end

        def scratchpad_actions(html, card)
          add_card_to_deck(html, @presenter.deck, card) do
            button_attrs = {
              class: 'form-control btn',
              type: 'submit',
              name: 'slot',
            }

            html.tag('button',
                      button_attrs.merge(value: 'deck',
                                        title: 'Deck')
                    ) do
              html.icon('plus')
            end
          end
        end

        def remove_card_from_deck(html, card)
          path = "/decks/#{@presenter.deck[:id]}/cards/#{card[:card_id]}"

          html.delete_form(action: path, class: 'form-inline') do
            if card[:user_printing_id]
              html.input_hidden('user_printing_id', card[:user_printing_id])
            end

            html.delete_button
          end
        end

        def alternatives_link(html, deck, card)
          path = "/decks/#{deck[:id]}/cards/#{card[:card_id]}/alternatives"

          html.tag('a', title: 'Alternatives', href: path) do
            html.tag('i', class: 'fas fa-exchange-alt',
                     title: 'Alternatives') do
              html.tag('span', 'alternatives', class: 'alt-text')
            end
          end
        end

        def add_card_to_deck(html, deck, card, &block)
          path = "/decks/#{@presenter.deck[:id]}/cards"

          html.form(action: path, class: 'form-inline') do
            html.input_hidden('card_id', card[:card_id])

            block.call
          end
        end

        def synergy_deck_link(html, deck, card)
          path = "/decks/#{deck[:id]}/cards/#{card[:card_id]}/synergy"

          html.tag('a', href: path) do
            html.tag('i', class: 'fas fa-trophy',
                     title: 'Cards that work well with this') do
              html.tag('span', 'synergy', class: 'alt-text')
            end
          end
        end

        def breadcrumb(html)
          html.breadcrumb do
            html.breadcrumb_item('Collection')
          end
        end
      end
    end
  end
end
