module Web
  module Views
    module Decks
      class List
        DECK_LIST_HEADER = Html.render do |html|
          html.tag('thead') do
            html.tag('tr') do
              html.tag('th', 'Name')
              html.tag('th', 'Created')
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
            html.box_title('Decks')
            deck_list(html, @presenter.decks)
          end
        end

        def deck_list(html, decks, &block)
          html.striped_table do
            html.append_html(DECK_LIST_HEADER)

            html.tag('tbody') do
              decks.each do |deck|
                html.tag('tr') do
                  html.tag('td') do
                    html.tag('a', deck[:name], href: "/decks/#{deck[:id]}")
                    html.mtg.count_badge(deck[:card_count])
                  end

                  html.tag('td', deck[:created_at].to_s)

                  html.tag('td') do
                    html.delete_form(action: "/decks/#{deck[:id]}") do
                      html.icons.delete_button
                    end
                  end
                end
              end
            end
          end
        end

        def breadcrumb(html)
          html.tag('div', class: 'row') do
            html.tag('div', class: 'col-10') do
              html.breadcrumb do
                html.breadcrumb_item('Decks')
              end
            end

            html.tag('div', class: 'col') do
              html.tag('ul', class: 'nav justify-content-end') do
                html.tag('li') do
                  html.link('/decks/new', 'Add deck',
                            class: 'nav-link btn btn-light')
                end
              end
            end
          end
        end
      end
    end
  end
end
