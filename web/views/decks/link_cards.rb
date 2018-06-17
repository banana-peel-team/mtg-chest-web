require_relative 'show'

module Web
  module Views
    module Decks
      class LinkCards < Web::Views::Decks::Show
        def body(html)
          html.tag('h2', "Link cards")

          if @presenter.card_count > 0
            cards_list(html, @presenter.paginated)
          else
            if @presenter.total_missing > 0
              html.simple_card('Missing cards', type: :warning) do
                html.append_text(
                  %Q(This deck contains cards that you don't own)
                )
              end
            else
              html.simple_card('All done', type: :success) do
                html.append_text(
                  %Q(All deck cards are linked)
                )
              end
            end
          end

          Helpers.pagination(
            html, @presenter.current_page, @presenter.total_pages
          )
        end

        def card_name_cell(html, card)
          html.tag('td') do
            Helpers.printing_symbol(html, card)

            html.append_html(card[:card_name])

            html.tag('span', class: 'ml-3') do
              path = "/collection/imports/#{card[:import_id]}"
              html.link(path, card[:import_title])
            end

            Helpers.count_badge(html, card[:count])
            Helpers.card_text(html, card)
          end
        end

        def actions(html, card)
          add_card_to_deck(html, @presenter.deck, card) do
            button_attrs = {
              class: 'form-control btn',
              type: 'submit',
              name: 'slot',
            }

            html.tag('button',
                      button_attrs.merge(value: 'deck',
                                         title: 'Use this card')
                    ) do
              html.icon('link')
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

            html.breadcrumb_item do
              html.link("/decks/#{@presenter.deck[:id]}/edit", 'Edit Deck')
            end
            html.breadcrumb_item('Link cards')
          end
        end
      end
    end
  end
end
