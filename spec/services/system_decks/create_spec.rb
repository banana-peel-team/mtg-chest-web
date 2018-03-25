RSpec.describe Services::SystemDecks::Create do
  let(:service) { Services::SystemDecks::Create }

  let(:deck_db) { Fabricate(:deck_database) }
  # Default values for these fabricators might not be the best,
  # we'll need to change the fabricator type.
  let!(:card_1) { Fabricate(:card, name: "Grafdigger's Cage") }
  let!(:card_2) { Fabricate(:card, name: 'Reflector Mage') }
  let!(:land) { Fabricate(:basic_land_card) }

  describe '.perform' do
    let(:attrs) do
      {
        event_id: 18787,
        event_title: 'GP Phoenix 2018',
        event_format: 'MO',
        deck_id: 317513,
        deck_title: 'Humans',
        cards_ids: [
          card_1[:id],
          card_1[:id],
          card_2[:id],
          card_2[:id],
          card_2[:id],
          card_2[:id],
          land[:id],
          land[:id],
        ]
      }
    end

    subject(:perform) { service.perform(deck_db, attrs) }

    it 'creates a system deck' do
      expect {
        perform
      }.to change(Deck.where(user_id: nil), :count).by(1)
    end

    it 'increments card_1 score' do
      expect {
        perform
      }.to change {
        card_1.reload.scores[deck_db.key] || 0
      }.from(0).to(1)
    end

    it 'does not update basic land score' do
      expect {
        perform
      }.to_not change {
        land.reload.scores[deck_db.key] || 0
      }
    end

    it 'updates max_score on deck_database' do
      expect {
        perform
      }.to change(deck_db.reload, :max_score).from(0).to(1)
    end

    context 'when cards are already scored' do
      before do
        card_1.update(scores: {deck_db.key => 10})
      end

      it 'increments card_1 score' do
        expect {
          perform
        }.to change {
          card_1.reload.scores[deck_db.key] || 0
        }.by(1)
      end

      it 'updates max_score on deck_database' do
        expect {
          perform
        }.to change(deck_db.reload, :max_score).to(11)
      end
    end

    it 'creates the deck metadata' do
      expect {
        perform
      }.to change(DeckMetadata, :count).by(1)
    end

    it 'creates eight deck cards' do
      expect {
        perform
      }.to change(DeckCard, :count).by(8)
    end

    it "sets deck's card count to eight" do
      deck = perform
      expect(deck.card_count).to eq(8)
    end

    it 'creates card relation' do
      expect {
        perform
      }.to change(CardRelation, :count).by(1)
    end

    it 'does not create relations for the land' do
      perform

      land_relations = CardRelation.where(
        card_1_id: land[:id]
      ).or(
        card_2_id: land[:id]
      )

      expect(land_relations).to be_empty
    end

    context 'creating another deck with same cards' do
      let(:attrs_2) do
        {
          event_id: 18787,
          event_title: 'GP Phoenix 2018',
          event_format: 'MO',
          deck_id: attrs[:deck_id] + 1,
          deck_title: 'Humans',
          cards_ids: [
            card_1[:id],
            card_1[:id],
            card_2[:id],
            card_2[:id],
            card_2[:id],
            card_2[:id],
            land[:id],
            land[:id],
          ]
        }
      end

      it 'increases card relation strength' do
        service.perform(deck_db, attrs_2)

        ids = [card_1[:id], card_2[:id]].sort


        expect {
          service.perform(deck_db, attrs)
        }.to change {
          CardRelation.first(
            card_1_id: ids[0],
            card_2_id: ids[1],
          ).strength
        }.by(1)
      end
    end

    context 'having cards not in the deck' do
      let!(:card_3) { Fabricate(:card) }

      it 'creates only one card relation' do
        expect {
          perform
        }.to change(CardRelation, :count).by(1)
      end

      it 'does not create relations for that card' do
        perform

        card_relations = CardRelation.where(
          card_1_id: card_3[:id]
        ).or(
          card_2_id: card_3[:id]
        )

        expect(card_relations).to be_empty
      end
    end
  end
end
