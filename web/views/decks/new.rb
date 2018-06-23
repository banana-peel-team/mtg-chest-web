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
          html.box do
            html.box_title('Create deck')

            form = html.form(action: '/decks/import-list')

            form.render do
              html.simple_card('Create from card list') do
                form.group do
                  form.input('text', :name, label: 'Name', required: true)
                end

                form.group do
                  form.textarea(:list, required: true, placeholder: '1 Swamp')
                end

                form.submit('Create')
              end
            end
          end
        end

        def breadcrumb(html)
          html.breadcrumb do
            html.breadcrumb_item do
              html.link('/decks', 'Decks')
            end

            html.breadcrumb_item('New')
          end
        end
      end
    end
  end
end
