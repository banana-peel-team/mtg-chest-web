module Web
  module Views
    module Editions
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
              html.append_html(@presenter.edition[:name])
              html.mtg.count_badge(@presenter.edition[:card_count])
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
          html.breadcrumb do
            html.breadcrumb_item do
              html.link('/editions', 'Editions')
            end

            html.breadcrumb_item(@presenter.edition[:name])
          end
        end
      end
    end
  end
end
