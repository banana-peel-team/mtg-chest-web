module Web
  module Views
    module Extensions
      module Pagination
        module Extension
          extend self

          def page_link(html, number, current, text = number.to_s)
            cls = 'page-item'
            cls << ' disabled' if number.nil?
            cls << ' active' if number == current

            html.tag('li', class: cls) do
              html.link("?page=#{number}", text, class: 'page-link')
            end
          end

          # TODO: Improve
          def render(html, current_page, total_pages)
            return if total_pages < 2 && current_page < 2

            if total_pages <= 7
              first_top = total_pages
            else
              first_top = [3, total_pages].min
            end

            html.tag('ul', class: 'pagination') do
              if current_page > 1
                page_link(html, current_page - 1, current_page, 'Prev')
              else
                page_link(html, nil, current_page, 'Prev')
              end

              (1..first_top).each do |i|
                page_link(html, i, current_page)
              end

              if first_top < total_pages
                last_start = [5, (total_pages - 2)].max

                if current_page < last_start && current_page > first_top
                  page_link(html, current_page, current_page)
                end

                (last_start..total_pages).each do |i|
                  page_link(html, i, current_page)
                end
              end

              if current_page < total_pages
                page_link(html, current_page + 1, current_page, 'Next')
              else
                page_link(html, nil, current_page, 'Next')
              end
            end
          end
        end

        def pagination(*args)
          Pagination::Extension.render(self, *args)
        end
      end
    end
  end
end
