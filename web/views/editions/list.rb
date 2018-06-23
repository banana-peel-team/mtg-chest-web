module Web
  module Views
    module Editions
      class List
        EDITION_LIST_HEADER = Html.render do |html|
          html.tag('thead') do
            html.tag('tr') do
              html.tag('th', 'Icon')
              html.tag('th', 'Name')
              html.tag('th', 'Code')
            end
          end
        end.freeze

        def initialize(attrs)
          @current_user = attrs[:current_user]
          @editions = attrs[:editions]
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
            html.box_title('Editions')

            editions_list(html, @editions)
          end
        end

        def editions_list(html, editions, &block)
          html.striped_table do
            html.append_html(EDITION_LIST_HEADER)

            html.tag('tbody') do
              editions.each do |edition|
                html.tag('tr') do
                  html.tag('td') do
                    html.mtg.edition_icon(edition)
                  end
                  html.tag('td') do
                    html.link("/editions/#{edition[:code]}", edition[:name])
                  end
                  html.tag('td', edition[:code])
                end
              end
            end
          end
        end

        def breadcrumb(html)
          html.breadcrumb do
            html.breadcrumb_item('Editions')
          end
        end
      end
    end
  end
end
