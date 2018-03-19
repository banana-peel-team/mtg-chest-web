RSpec.shared_examples "a printing" do |data|
  it_behaves_like "a card"

  it { is_expected.to include('printing_id' => Integer) }
  it { is_expected.to include('multiverse_id' => Integer) }
end
