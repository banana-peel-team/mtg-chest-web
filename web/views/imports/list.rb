module Web
  module Views
    module Imports
      class List
        TABLE_HEADER = Html.render do |html|
          html.tag('thead') do
            html.tag('tr') do
              html.tag('th', 'Title')
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
          html.tag('h2', 'Imports')
          import_list(html, @presenter.imports)
        end

        def import_list(html, imports, &block)
          html.striped_table do
            html.append_html(TABLE_HEADER)

            html.tag('tbody') do
              imports.each do |import|
                html.tag('tr') do
                  html.tag('td') do
                    html.link(
                      "/collection/imports/#{import[:id]}", import[:title]
                    )
                    Helpers.count_badge(html, import[:user_printing_count])
                  end

                  html.tag('td', import[:created_at].to_s)

                  html.tag('td') do
                    html.delete_form(action: "/collection/imports/#{import[:id]}") do
                      html.delete_button
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
                html.breadcrumb_item('Imports')
              end
            end

            html.tag('div', class: 'col') do
              html.tag('ul', class: 'nav justify-content-end') do
                html.tag('li') do
                  html.tag('a', 'New', class: 'nav-link btn btn-light',
                                       href: '/collection/import')
                end
              end
            end
          end
        end
      end
    end
  end
end
