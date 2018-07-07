require_relative 'extensions/table'

module Web
  module Routes
    module Presenters
      module EditionsList
        extend self

        def context(params)
          {
            editions: Extensions::Table.table(editions, params, {
              sort: Queries::Editions,
              default_sort: 'edition_date',
              default_dir: 'desc',
              sort_columns: [
                'edition_name',
                'edition_date',
                'edition_code',
              ],
              paginate: true,
            }),
          }
        end

        private

        def editions
          Queries::Editions.list
        end
      end
    end
  end
end
