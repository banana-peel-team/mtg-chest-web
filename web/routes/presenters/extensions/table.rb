module Web
  module Routes
    module Presenters
      module Extensions
        module Table
          extend self

          PER_PAGE = 50.0

          def table(ds, params, options)
            sorting = nil

            if (sort = options[:sort])
              p_sort = params['sort']
              p_direction = params['dir']

              sorting = { column: p_sort, direction: p_direction }
              ds = options[:sort].sort(ds, p_sort, p_direction)
            end

            paginated = options[:paginate]
            list =
              if paginated
                paginate(ds, params)
              else
                ds
              end

            {
              list: list,
              sorting: sorting,
              paginated: paginated,
            }
          end

          private

          def paginate(dataset, params)
            count = dataset.count
            total_pages = (count / PER_PAGE).ceil
            current_page = (params['page'] || 1).to_i

            items = dataset
              .limit(PER_PAGE)
              .offset((current_page - 1) * PER_PAGE)
              .all

            {
              items: items,
              count: count,
              total_pages: total_pages,
              current_page: current_page,
              params: params
            }
          end
        end
      end
    end
  end
end
