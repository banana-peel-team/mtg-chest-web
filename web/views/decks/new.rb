module Web
  module Views
    module Decks
      class New
        def initialize(attrs)
          @current_user = attrs[:current_user]
          #@presenter = attrs[:presenter]
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
          html.tag('h2', 'Create deck')

          html.form(action: '/decks/import-list') do
            html.tag('div', class: 'card mt-3') do
              html.tag('div', 'Create from card list', class: 'card-header')
              html.tag('div', class: 'card-body') do
                html.tag('div', class: 'form-group') do
                  html.stag(
                    'input',
                    class: 'form-control',
                    type: 'text',
                    placeholder: 'Name',
                    required: 'required',
                    name: 'deck[name]'
                  )
                end

                html.tag('div', class: 'form-group') do
                  html.tag(
                    'textarea',
                    class: 'form-control',
                    placeholder: '1 Swamp',
                    required: 'required',
                    name: 'deck[list]'
                  )
                end

                html.tag('div', class: 'form-group mt-3') do
                  html.stag(
                    'input',
                    class: 'btn btn-primary',
                    type: 'submit',
                    value: 'Create'
                  )
                end
              end
            end
          end
        end

        def breadcrumb(html)
          html.breadcrumb do
            html.breadcrumb_item do
              html.tag('a', 'Decks', href: '/decks')
            end

            html.breadcrumb_item('New')
          end
        end
      end
    end
  end
end
