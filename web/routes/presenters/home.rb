module Web
  module Routes
    module Presenters
      class Home
        def initialize(user)
          @user = user
        end

        def context
          {
            user: @user,
          }
        end
      end
    end
  end
end
