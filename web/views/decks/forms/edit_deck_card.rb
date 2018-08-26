module Web
  module Views
    module Decks
      module Forms
        class EditDeckCard < ::Html::Form
          option :inline_values, true
          option :method, 'post'

          def draw
            flag = options.fetch(:flag) { true }

            buttons =
              if options[:icon]
                ::Html::Form::ButtonGroup.new(
                  field(::Html::Form::Button, {
                    name: 'status',
                    value: 'flagged',
                    icon: 'flag',
                    label: 'Flag for removal',
                    unless: flag ? :is_flagged : true,
                  }),
                  field(::Html::Form::Button, {
                    name: 'status',
                    value: 'unlinked',
                    icon: 'unlink',
                    label: 'Unlink',
                    if: :user_printing_id,
                  }),
                  field(::Html::Form::Button, {
                    name: 'status',
                    value: 'removed',
                    icon: 'trash-alt',
                    label: 'Remove',
                    style: 'danger',
                  }),
                )
              else
                raise 'Not implemented.'
              end

            ::Html::Component.new(
              ::Html::Form::HiddenField.new(
                name: child_name('card_id'),
                type: 'hidden',
                source: :card_id,
              ),
              buttons,
            )
          end

          private

          def action(context)
            card = context[:_current_row]

            "/deck-cards/#{card[:deck_card_id]}"
          end
        end
      end
    end
  end
end
