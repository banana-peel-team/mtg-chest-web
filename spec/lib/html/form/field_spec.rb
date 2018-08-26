require './lib/html/form/field'
require './web/views/html'

RSpec.describe Html::Form::Field do
  let(:options) { {} }

  subject(:field) { Html::Form::Field.new(options) }

  describe 'render' do
    let(:ctx) { {} }

    subject(:html) do
      Web::Views::Html.render { |html| field.render(html, ctx) }
    end

    it { is_expected.to match(/<input .*? \/>/) }

    context 'with type' do
      let(:options) { { type: 'date' } }

      it { is_expected.to include('type="date"') }
    end

    context 'with label' do
      let(:options) { { label: 'Username' } }

      it { is_expected.to include('placeholder="Username"') }
    end

    context 'with name' do
      let(:options) { { name: { user: 'name' } } }

      it { is_expected.to include('name="user[name]"') }
      it { is_expected.to include('id="user-name"') }

      context 'with name in context._field' do
        let(:_field) { { name: 'field-name' } }
        let(:ctx) { { _field: _field } }

        it { is_expected.to include('name="field-name"') }
      end
    end

    context 'with source' do
      let(:options) { { source: :name } }

      context 'and there are errors in the context' do
        let(:ctx) { { _current_form_errors: { name: [:invalid] } } }

        it { is_expected.to match(/<div.*?<\/div>/) }
        it { is_expected.to include('class="form-control is-invalid"') }
        it { is_expected.to include('class="invalid-feedback"') }
      end

      context 'and there is a value in the context' do
        let(:ctx) { { _current_form_values: { name: 'John' } } }

        it { is_expected.to include('value="John"') }
      end
    end
  end

  describe '#tag_name' do
    let(:name) { nil }

    subject(:tag_name) { field.send(:tag_name, name) }

    context ':a' do
      let(:name) { :a }

      it { is_expected.to eq('a') }
    end

    context '{ a: :b }' do
      let(:name) { { a: :b } }

      it { is_expected.to eq('a[b]') }
    end

    context '{ a: { b: :c } }' do
      let(:name) { { a: { b: :c } } }

      it { is_expected.to eq('a[b][c]') }
    end
  end
end
