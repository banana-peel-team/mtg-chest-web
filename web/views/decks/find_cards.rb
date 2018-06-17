require_relative 'show'
module Web
  module Views
    module Decks
      class FindCards < Web::Views::Decks::Show
        def body(html)
          html.tag('h2', "Suggested cards")

          form = HtmlForm.new(html: html)

          form.render(method: 'get') do
            form.checkbox(:all, label: 'Show all', value: '1', inline: true)
            form.submit('Refresh')
          end

          cards_list(html, @presenter.paginated)

          Helpers.pagination(
            html, @presenter.current_page, @presenter.total_pages
          )
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
                                         title: 'Add to deck')
                    ) do
              html.tag('i', class: 'fas fa-plus')
            end
            html.tag('button',
                      button_attrs.merge(value: 'scratchpad',
                                         title: 'Add to scratchpad')
                    ) do
              html.tag('i', class: 'fas fa-pencil-alt')
            end

            html.tag('button',
                      button_attrs.merge(value: 'ignored',
                                         title: 'Ignore this card')
                    ) do

              html.tag('i', class: 'fas fa-thumbs-down')
            end
          end
        end

        def breadcrumb(html)
          html.breadcrumb do
            html.breadcrumb_item do
              html.tag('a', 'Decks', href: '/decks')
            end
            html.breadcrumb_item do
              deck_path = "/decks/#{@presenter.deck[:id]}"
              html.tag('a', @presenter.deck[:name], href: deck_path)
            end
            html.breadcrumb_item('Find cards')
          end
        end
      end
    end
  end
end
