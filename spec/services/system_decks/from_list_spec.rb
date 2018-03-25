RSpec.describe Services::SystemDecks::FromList do
  let(:service) { Services::SystemDecks::FromList }

  let(:deck_db) { Fabricate(:deck_database) }

  let!(:card_1) { Fabricate(:card, name: "Grafdigger's Cage") }
  let!(:card_2) { Fabricate(:card, name: 'Reflector Mage') }

  describe '.create' do
    let(:contents) { '' }
    let(:attrs) do
      {
        event_id: 18787,
        event_title: 'GP Phoenix 2018',
        event_format: 'MO',
        deck_id: 317513,
        deck_title: 'Humans',
        file: StringIO.new(contents),
      }
    end

    subject(:create) { service.create(deck_db, attrs) }

    context 'with a valid list' do
      let(:contents) do
        "2 Grafdigger's Cage\n" +
        "4 Reflector Mage\n"
      end

      it 'creates a system deck' do
        expect {
          create
        }.to change(Deck.where(user_id: nil), :count).by(1)
      end

      it 'increments card_1 score' do
        expect {
          create
        }.to change {
          card_1.reload.scores[deck_db.key] || 0
        }.from(0).to(1)
      end

      it 'updates max_score on deck_database' do
        expect {
          create
        }.to change(deck_db.reload, :max_score).from(0).to(1)
      end

      context 'when cards are already scored' do
        before do
          card_1.update(scores: {deck_db.key => 10})
        end

        it 'increments card_1 score' do
          expect {
            create
          }.to change {
            card_1.reload.scores[deck_db.key] || 0
          }.by(1)
        end

        it 'updates max_score on deck_database' do
          expect {
            create
          }.to change(deck_db.reload, :max_score).to(11)
        end
      end

      it 'creates the deck metadata' do
        expect {
          create
        }.to change(DeckMetadata, :count).by(1)
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
