module Web
  module Views
    module Decks
      module Forms
        class AddCards < ::Html::Form
          option :method, 'post'

          def draw
            ::Html::Component.new(
              field(::Html::Form::Checkbox, {
                name: 'scratchpad',
                label: 'Scratchpad',
                inline: true,
              }),
              ::Html::Form::Row.new(
                field(::Html::Form::Textarea, {
                  name: 'list',
                  label: 'Cards',
                  placeholder: '1 Swamp',
                }),
              ),
              ::Html::Form::Row.new(
                ::Html::Form::Submit.new(label: 'Add')
              ),
            )
          end

          def action(context)
            "/decks/#{context[:deck][:id]}/add-cards"
          end
        end
      end
    end
  end
end
