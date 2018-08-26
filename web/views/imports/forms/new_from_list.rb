module Web
  module Views
    module Imports
      module Forms
        class NewFromList < ::Html::Form
          option :method, 'post'
          option :action, '/collection/import-list'

          def draw
            ::Html::Component.new(
              field(::Html::Form::TextField, {
                name: 'title',
                label: 'Title',
                required: true,
              }),
              ::Html::Form::Row.new(
                ::Html::Column.new(width: 5),
                ::Html::Column.new(
                  field(::Html::Form::Checkbox, {
                    name: 'foil',
                    label: 'Foil',
                    inline: true,
                  }),
                  width: 2
                ),
                ::Html::Column.new(
                  field(::Html::Form::SelectField, {
                    name: 'condition',
                    options: {
                      'MN' => 'Mint',
                      'NM' => 'Near Mint',
                      'LP' => 'Lightly Played',
                      'MP' => 'Moderately Played',
                      'HP' => 'Heavily Played',
                      'DM' => 'Damaged',
                    },
                  }),
                  width: 3
                ),
                ::Html::Column.new(
                  field(::Html::Form::TextField, {
                    name: 'set',
                    label: 'Set code',
                    required: true,
                  }),
                ),
              ),
              ::Html::Form::Row.new(
                field(::Html::Form::Textarea, {
                  name: 'list',
                  label: 'Cards',
                  placeholder: '1 Swamp',
                }),
              ),
              ::Html::Form::Submit.new(label: 'Import'),
            )
          end
        end
      end
    end
  end
end
