module Web
  module Views
    module Decks
      module Forms
        class New < ::Html::Form
          option :method, 'post'
          option :action, '/decks/import-list'

          def draw
            ::Html::Component.new(
              ::Html::Form::Group.new(
                field(::Html::Form::TextField, {
                  name: 'name',
                  label: 'Name',
                  required: true,
                }),
              ),
              ::Html::Form::Group.new(
                field(::Html::Form::Textarea, {
                  name: 'list',
                  label: 'Cards',
                  placeholder: '1 Swamp',
                  required: true,
                }),
              ),
              ::Html::Form::Submit.new(label: 'Create'),
            )
          end
        end
      end
    end
  end
end
