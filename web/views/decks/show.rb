module Web
  module Views
    module Decks
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
              html.tag('th', 'Actions')
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
            html.append_html('Deck cards')
            Helpers.count_badge(html, @presenter.deck[:card_count])
          end
          cards_list(html, @presenter.cards)


          #if count = @presenter.ignored.count > 0
            #html.tag('h2', 'Ignored')
            #cards_list(html, @presenter.ignored) do |card|
              ## TODO
              ##ignored_actions(html, card)
            #end
          #end
        end

        def cards_list(html, cards, &block)
          cls = 'table table-striped table-sm table-hover mt-5'
          html.tag('table', class: cls) do
            html.append_html(CARDS_LIST_HEADER)

            html.tag('tbody') do
              cards.each do |card|
                html.tag('tr') do
                  html.tag('td') do
                    Helpers.card_score(html, @presenter.rated_decks, card)
                  end
                  card_name_cell(html, card)
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
                    if block_given?
                      block.call(card)
                    else
                      actions(html, card)
                    end
                  end
                end
              end
            end
          end
        end

        def card_name_cell(html, card)
          html.tag('td') do
            Helpers.printing_symbol(html, card)

            html.append_html(card[:card_name])

            Helpers.count_badge(html, card[:count])
            Helpers.card_text(html, card)
          end
        end

        def actions(html, card)
          base = "/decks/#{@presenter.deck[:id]}/cards/#{card[:card_id]}"

          html.icon_link(
            base + "/alternatives", 'exchange-alt', 'Alternatives'
          )
          html.append_html(' ')
          html.icon_link(base + "/synergy", 'trophy', 'Synergy')
        end

        def delete_card(html, card)
          path = "/deck-cards/#{card[:deck_card_id]}"

          html.delete_form(action: path, class: 'form-inline') do
            html.delete_button
          end
        end

        def add_card_to_deck(html, deck, card, &block)
          path = "/decks/#{@presenter.deck[:id]}/cards"

          html.form(action: path, class: 'form-inline') do
            html.input_hidden('card_id', card[:card_id])
            if card[:user_printing_id]
              html.input_hidden('user_printing_id', card[:user_printing_id])
            end

            block.call
          end
        end

        def breadcrumb(html)
          html.tag('div', class: 'row') do
            html.tag('div', class: 'col-8') do
              html.breadcrumb do
                html.breadcrumb_item do
                  html.link('/decks', 'Decks')
                end

                html.breadcrumb_item(@presenter.deck[:name])

                html.breadcrumb_item do
                  html.link(
                    "/decks/#{@presenter.deck[:id]}/find-cards", 'Find cards'
                  )
                end
              end
            end

            html.tag('div', class: 'col') do
              html.tag('ul', class: 'nav justify-content-end') do
                html.tag('li', class: 'nav-item mr-3') do
                  path = "/decks/#{@presenter.deck[:id]}/list"
                  html.link(path, 'Card list', {
                    class: 'nav-link btn btn-light',
                  })
                end

                html.tag('li', class: 'nav-item mr-3') do
                  path = "/decks/#{@presenter.deck[:id]}/edit"
                  html.link(path, 'Edit cards', {
                    class: 'nav-link btn btn-light',
                  })
                end
              end
            end
          end
        end
      end
    end
  end
end
