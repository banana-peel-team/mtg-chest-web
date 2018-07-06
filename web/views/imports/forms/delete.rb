require_relative '../../components/form'
require_relative '../../components/forms/button'

module Web
  module Views
    module Imports
      module Forms
        class Delete < Components::Form
          def build_elements
            if options[:icon]
              [
                Components::Forms::Button.new(
                  icon: 'trash-alt', label: 'Delete', style: 'danger'
                )
              ]
            else
              raise 'Not implemented.'
            end
          end

          def method(_context)
            'delete'
          end

          def action(context)
            import = context[:_current_row]

            "/collection/imports/#{import[:import_id]}"
          end
        end
      end
    end
  end
end
