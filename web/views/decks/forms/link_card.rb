module Web
  module Views
    module Decks
      module Forms
        class LinkCard < ::Html::Form
          option :method, 'post'

          def draw
            buttons =
              if options[:icon]
                ::Html::Form::ButtonGroup.new(
                  field(::Html::Form::Button, {
                    name: 'slot',
                    value: 'deck',
                    icon: 'link',
                    label: 'Use this card',
                  }),
                )
              else
                raise 'Not implemented.'
              end

            ::Html::Component.new(
              field(::Html::Form::HiddenField, {
                name: 'card_id',
                type: 'hidden',
                source: :card_id,
              }),
              field(::Html::Form::HiddenField, {
                name: 'user_printing_id',
                type: 'hidden',
                source: :user_printing_id,
              }),
              buttons,
            )
          end

          def action(context)
            "/decks/#{context[:deck][:id]}/cards"
          end
        end
      end
    end
  end
end
