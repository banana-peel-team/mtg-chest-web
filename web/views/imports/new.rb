module Web
  module Views
    module Imports
      class New
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
          html.tag('h2', 'Import cards')

          form = HtmlForm.new(html: html, namespace: 'import')

          html.simple_card('Import from a file') do
            from_file(form)
          end

          html.simple_card('Import from card list') do
            from_card_list(form)
          end
        end

        def from_card_list(form)
          form.render(action: '/collection/import-list') do
            form.input('text', :title, label: 'Title', required: true)

            form.row do
              form.tag('div', class: 'col-5')
              form.tag('div', class: 'col-2') do
                form.checkbox(:foil, {
                  label: 'Foil',
                  inline: true,
                })
              end

              form.tag('div', class: 'col-3') do
                form.select(:condition, {
                  'MN' => 'Mint',
                  'NM' => 'Near Mint',
                  'LP' => 'Lightly Played',
                  'MP' => 'Moderately Played',
                  'HP' => 'Heavily Played',
                  'DM' => 'Damaged',
                })
              end

              form.tag('div', class: 'col') do
                form.input('text', :set, label: 'Set code', required: true)
              end
            end

            form.group do
              form.textarea(:list, label: '1 Swamp', required: true)
            end

            form.submit('Import')
          end
        end

        def from_file(form)
          form.render(
            action: '/collection/import',
            enctype: 'multipart/form-data'
          ) do
            form.input('text', :title, label: 'Title', required: true)

            form.row do
              form.tag('div', class: 'col-8') do
                form.radiobox(:source, {
                  label: 'Deckbox',
                  inline: true,
                  id: 'deckbox',
                  value: 'deckbox',
                })

                form.radiobox(:source, {
                  label: 'MTG Manager',
                  inline: true,
                  id: 'mtg-manager',
                  value: 'mtg-manager',
                })

                form.radiobox(:source, {
                  label: 'Decked Builder (deck)',
                  inline: true,
                  id: 'decked',
                  value: 'decked-builder',
                })
              end

              form.tag('div', class: 'col') do
                form.file(:file, required: true)
              end
            end

            form.submit('Import')
          end
        end

        def breadcrumb(html)
          html.breadcrumb do
            html.breadcrumb_item do
              html.link('/collection/imports', 'Imports')
            end
            html.breadcrumb_item('New')
          end
        end
      end
    end
  end
end
