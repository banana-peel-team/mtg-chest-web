module Web
  module Routes
    module Presenters
      module Extensions
        module Table
          extend self

          PER_PAGE = 50.0

          def table(ds, params, options)
            if (sorting = sorting_hash(params, options))
              ds = options[:sort].sort(
                ds.unordered, sorting[:column], sorting[:direction].to_sym
              )
            end

            paginated = options[:paginate]
            list =
              if paginated
                paginate(ds, params)
              else
                ds.all
              end

            {
              list: list,
              sorting: sorting,
              paginated: paginated,
            }
          end

          private

          def sorting_hash(params, options)
            if (sort = options[:sort])
              if (p_sort = params['sort']) && valid_sort?(p_sort, options)
                p_direction = params['dir']
              else
                p_sort = options[:default_sort]
                p_direction = options[:default_dir] || 'asc'
              end

              { column: p_sort, direction: p_direction }
            end
          end

          def valid_sort?(column, options)
            options[:sort_columns].include?(column)
          end

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
