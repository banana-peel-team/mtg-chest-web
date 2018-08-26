require './lib/html/component'

RSpec.describe Html::Component do
  subject(:component) { Html::Component.new }

  describe '#nest_into' do
    let(:parent) { nil }
    let(:child) { nil }

    subject(:nested) { component.send(:nest_into, parent, child) }

    context 'nesting :a into nil' do
      let(:parent) { nil }
      let(:child) { :a }

      it { is_expected.to eq(:a) }
    end

    context 'nesting :b into :a' do
      let(:parent) { :a }
      let(:child) { :b }

      it { is_expected.to eq(a: :b) }
    end

    context 'nesting :c into { a: :b }' do
      let(:parent) { { a: :b } }
      let(:child) { :c }

      it { is_expected.to eq(a: { b: :c }) }
    end

    context 'nesting { c: :d } into { a: :b }' do
      let(:parent) { { a: :b } }
      let(:child) { { c: :d } }

      it { is_expected.to eq(a: { b: { c: :d } }) }
    end
  end

  describe '#tag_id' do
    let(:id) { nil }

    subject(:tag_id) { component.send(:tag_id, id) }

    context ':a' do
      let(:id) { :a }

      it { is_expected.to eq('a') }
    end

    context '{ a: :b }' do
      let(:id) { { a: :b } }

      it { is_expected.to eq('a-b') }
    end

    context '{ a: { b: :c } }' do
      let(:id) { { a: { b: :c } } }

      it { is_expected.to eq('a-b-c') }
    end
  end
end
