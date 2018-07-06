require_relative 'field'

module Web
  module Views
    module Components
      module Forms
        class Password < Text
          private

          def default_options
            super.merge({
              type: 'password',
            })
          end

          def field_value(_context)
            nil
          end
        end
      end
    end
  end
end
