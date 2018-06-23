module Web
  module Views
    module Imports
      class Show
        TABLE_HEADER = Html.render do |html|
          html.tag('thead') do
            html.tag('tr') do
              html.tag('th', 'Score')
              html.tag('th', 'Name')
              html.tag('th', 'Tags')
              html.tag('th', 'Cost')
              html.tag('th', 'Identity')
              html.tag('th', 'P/T')
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
              html.append_text(@presenter.import[:title])
              html.mtg.count_badge(@presenter.import[:user_printing_count])
            end

            cards_list(html, @presenter.printings)
          end
        end

        def cards_list(html, cards, &block)
          html.striped_table do
            html.append_html(TABLE_HEADER)

            html.tag('tbody') do
              cards.each do |card|
                html.tag('tr') do
                  html.tag('td') do
                    html.mtg.card_score(@presenter.rated_decks, card)
                  end

                  html.tag('td') do
                    html.mtg.printing_name_with_info(card)
                    html.mtg.card_text(card)
                  end

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
                end
              end
            end
          end
        end

        def breadcrumb(html)
          html.tag('div', class: 'row') do
            html.tag('div', class: 'col-7') do
              html.breadcrumb do
                html.breadcrumb_item do
                  html.tag('a', 'Imports', href: '/collection/imports')
                end

                html.breadcrumb_item(@presenter.import[:title])
              end
            end

            html.tag('div', class: 'col') do
              html.tag('ul', class: 'nav justify-content-end') do
                html.tag('li', class: 'nav-item mr-4') do
                  path = "/collection/imports/#{@presenter.import[:id]}/list"

                  html.tag('a', class: 'nav-link btn btn-light', href: path) do
                    html.append_html('Card list')
                  end
                end
                html.tag('li', class: 'nav-item mr-4') do
                  path =
                    "/collection/imports/#{@presenter.import[:id]}/deckbox"

                  html.tag('a', class: 'nav-link btn btn-light', href: path) do
                    html.append_html('Export to deckbox')
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
