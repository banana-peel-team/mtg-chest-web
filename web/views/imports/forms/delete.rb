module Web
  module Views
    module Imports
      module Forms
        class Delete < ::Html::Form
          option :method, 'delete'

          def draw
            if options[:icon]
              ::Html::Form::Button.new(
                icon: 'trash-alt', label: 'Delete', style: 'danger'
              )
            else
              raise 'Not implemented.'
            end
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
