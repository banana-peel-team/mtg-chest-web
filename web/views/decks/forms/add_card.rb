module Web
  module Views
    module Decks
      module Forms
        class AddCard < ::Html::Form
          option :inline_values, true
          option :method, 'post'

          def draw
            buttons =
              if options[:icon]
                ::Html::Form::ButtonGroup.new(
                  field(::Html::Form::Button, {
                    name: 'slot',
                    value: 'deck',
                    icon: 'plus',
                    label: 'Add to deck',
                  }),
                  field(::Html::Form::Button, {
                    name: 'slot',
                    value: 'scratchpad',
                    icon: 'pencil-alt',
                    label: 'Add to scratchpad',
                  }),
                  field(::Html::Form::Button, {
                    name: 'slot',
                    value: 'ignored',
                    icon: 'thumbs-down',
                    label: 'Ignore this card',
                  }),
                )
              else
                raise 'Not implemented.'
              end

            ::Html::Component.new(
              field(::Html::Form::HiddenField, {
                name: 'card_id',
                source: :card_id,
              }),
              field(::Html::Form::HiddenField, {
                name: 'user_printing_id',
                source: :user_printing_id,
              }),
              buttons,
            )
          end

          private

          def action(context)
            "/decks/#{context[:deck][:id]}/cards"
          end
        end
      end
    end
  end
end
