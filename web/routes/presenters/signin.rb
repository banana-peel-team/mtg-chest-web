module Web
  module Routes
    module Presenters
      class Signin
        def initialize(form)
          @form = form
        end

        def context
          {
            user: @form,
          }
        end
      end
    end
  end
end
