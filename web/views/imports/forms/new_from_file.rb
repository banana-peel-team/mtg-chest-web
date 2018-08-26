module Web
  module Views
    module Imports
      module Forms
        class NewFromFile < ::Html::Form
          option :method, 'post'
          option :action, '/collection/import'
          option :multipart, true

          def draw
            ::Html::Component.new(
              field(::Html::Form::TextField, {
                name: 'title',
                label: 'Title',
                required: true,
              }),
              ::Html::Form::Row.new(
                ::Html::Column.new(
                  field(::Html::Form::Radiobox, {
                    id: '1',
                    name: 'source',
                    label: 'Deckbox',
                    value: 'deckbox',
                    inline: true,
                  }),
                  field(::Html::Form::Radiobox, {
                    id: '2',
                    name: 'source',
                    label: 'MTG Manager',
                    value: 'mtg-manager',
                    inline: true,
                  }),
                  field(::Html::Form::Radiobox, {
                    id: '3',
                    name: 'source',
                    label: 'Decked Builder (deck)',
                    value: 'decked-builder',
                    inline: true,
                  }),
                  width: 8
                ),
                ::Html::Column.new(
                  field(::Html::Form::FileField, {
                    name: 'file',
                    required: true,
                  }),
                ),
              ),
              ::Html::Form::Row.new(
                ::Html::Form::Submit.new(label: 'Import')
              ),
            )
          end
        end
      end
    end
  end
end
