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
          html.box do
            html.box_title do
              html.append_html('Deck cards')
              html.mtg.count_badge(@presenter.deck[:card_count])
            end

            cards_list(html, @presenter.cards)
          end
        end

        def cards_list(html, cards, &block)
          html.striped_table do
            html.append_html(CARDS_LIST_HEADER)

            html.tag('tbody') do
              cards.each do |card|
                html.tag('tr') do
                  html.tag('td') do
                    html.mtg.card_score(@presenter.rated_decks, card)
                  end
                  card_name_cell(html, card)
                  html.tag('td', class: 'mtgTags') do
                    html.mtg.mtg_icons(card[:types])
                    html.mtg.tags(card[:subtypes])
                  end
                  html.tag('td') do
                    html.mtg.card_cost(card)
                  end
                  html.tag('td') do
                    html.mtg.icons_list(card[:color_identity])
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
            html.mtg.printing_name_with_info(card)
            html.mtg.card_text(card)
          end
        end

        def actions(html, card)
          base = "/decks/#{@presenter.deck[:id]}/cards/#{card[:card_id]}"

          html.icons.icon_link(
            base + "/alternatives", 'exchange-alt', 'Alternatives'
          )
          html.append_html(' ')
          html.icons.icon_link(base + "/synergy", 'trophy', 'Synergy')
        end

        def add_card_to_deck(html, deck, card, &block)
          path = "/decks/#{@presenter.deck[:id]}/cards"

          html.form(action: path, class: 'form-inline') do |form|
            form.input_hidden('card_id', card[:card_id])
            if card[:user_printing_id]
              form.input_hidden('user_printing_id', card[:user_printing_id])
            end

            block.call(form)
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
