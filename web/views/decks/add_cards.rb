module Web
  module Views
    module Decks
      class AddCards
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
          html.tag('h2', 'Add cards')

          form = html.form(
            namespace: 'deck',
            action: "/decks/#{@presenter.deck[:id]}/add-cards",
          )

          html.simple_card('From card list') do
            form.render do
              html.tag('div', class: 'col') do
                form.checkbox(:scratchpad, label: 'Scratchpad', inline: true)
              end

              form.row do
                form.textarea(:list, label: '1 Swamp', required: true)
              end

              form.row do
                form.submit('Add')
              end
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
            html.breadcrumb_item do
              deck_path = "/decks/#{@presenter.deck[:id]}/edit"
              html.tag('a', 'Edit', href: deck_path)
            end

            html.breadcrumb_item('Add cards')
          end
        end
      end
    end
  end
end
