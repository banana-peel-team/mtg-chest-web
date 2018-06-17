module Web
  module Routes
    module Presenters
      class Signin
        attr_reader :errors
        attr_reader :values

        def initialize(attrs)
          @errors = attrs[:errors] || {}
          @values = attrs[:values] || {}
        end
      end
    end
  end
end
