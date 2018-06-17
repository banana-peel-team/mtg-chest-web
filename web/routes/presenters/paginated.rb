module Web
  module Routes
    module Presenters
      module Paginated
        PER_PAGE = 50.0

        def initialize(options)
          @params = options[:params] || {}
        end

        def card_count
          @card_count ||= dataset.count
        end

        def total_pages
          @total_pages ||= (dataset_items / PER_PAGE).ceil
        end

        def current_page
          @current_page ||= (@params['page'] || 1).to_i
        end

        def paginated
          dataset
            .limit(PER_PAGE)
            .offset((current_page - 1) * PER_PAGE)
            .all
        end

        private

        def dataset_items
          card_count
        end

        def dataset
          # To implement
        end
      end
    end
  end
end
