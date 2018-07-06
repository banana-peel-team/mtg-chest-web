module Web
  module Routes
    module Presenters
      class ImportsList
        attr_reader :user

        def initialize(user)
          @user = user
        end

        def context
          {
            imports: {
              list: imports,
            }
          }
        end

        private

        def imports
          Queries::ImportList.for_user(user).all
        end
      end
    end
  end
end
