RSpec.describe Services::Decks::FromList do
  let(:service) { Services::Decks::FromList }

  before do
    Fabricate(:card, name: 'Mountain')
    Fabricate(:card, name: 'Plains')
  end

  describe '.create' do
    let(:list) { }
    let(:user) { Fabricate(:user) }
    let(:attrs) do
      {
        name: 'Test name',
        list: list.split("\n")
      }
    end

    subject(:create) { service.create(user, attrs) }

    context 'with a valid list' do
      let(:list) do
        ["3 Mountain",
         "3 Plains"].join("\n")
      end

      it 'creates a deck' do
        expect {
          create
        }.to change(Deck, :count).by(1)
      end

      it 'creates 6 deck cards' do
        expect {
          create
        }.to change(DeckCard, :count).by(6)
      end

      it "sets deck's card count to 6" do
        deck = create
        expect(deck.card_count).to eq(6)
      end
    end
  end
end
