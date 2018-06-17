RSpec.describe Services::Decks::AddCard do
  let(:service) { Services::Decks::AddCard }

  let(:user) { Fabricate(:user) }
  let(:deck) { Fabricate(:deck) }

  describe '.perform' do
    let(:card) { Fabricate(:card) }
    let(:printing) { Fabricate(:printing, card: card) }
    let(:user_printing) { Fabricate(:user_printing, printing: printing) }
    let(:user_printing_id) { nil }

    let(:attrs) do
      { card_id: card[:id], user_printing_id: user_printing_id }
    end

    context 'adding card to deck' do
      let(:slot) { 'deck' }

      it 'adds the card' do
        expect {
          service.perform(deck, slot, attrs)
        }.to change(deck.deck_cards_dataset.where(slot: slot), :count).by(1)
      end

      context 'when card exists' do
        before do
          service.perform(deck, slot, card_id: card[:id])
        end

        it 'adds the card' do
          expect {
            service.perform(deck, slot, attrs)
          }.to change(deck.deck_cards_dataset.where(slot: slot), :count).by(1)
        end
      end

      context 'when card exists with a user printing' do
        before do
          service.perform(deck, slot,
                          card_id: card[:id],
                          user_printing_id: user_printing[:id])
        end

        it 'adds the card' do
          expect {
            service.perform(deck, slot, attrs)
          }.to change(deck.deck_cards_dataset.where(slot: slot), :count).by(1)
        end
      end

      context 'when card exists in scratchpad' do
        before do
          service.perform(deck, 'scratchpad', card_id: card[:id])
        end

        it 'adds a card to deck' do
          expect {
            service.perform(deck, slot, attrs)
          }.to change(deck.deck_cards_dataset.where(slot: slot), :count).by(1)
        end

        it 'removes a card from scratchpad' do
          expect {
            service.perform(deck, slot, attrs)
          }.to change(
            deck.deck_cards_dataset.where(slot: 'scratchpad'), :count
          ).by(-1)
        end
      end

      context 'when card exists in scratchpad with printing' do
        before do
          service.perform(deck, 'scratchpad',
                          card_id: card[:id],
                          user_printing_id: user_printing[:id])
        end

        it 'adds a card to deck' do
          expect {
            service.perform(deck, slot, attrs)
          }.to change(deck.deck_cards_dataset.where(slot: slot), :count).by(1)
        end

        it 'does not remove a card from scratchpad' do
          expect {
            service.perform(deck, slot, attrs)
          }.to_not change(
            deck.deck_cards_dataset.where(slot: 'scratchpad'), :count
          )
        end
      end
    end

    context 'adding card to deck with a user printing' do
      let(:user_printing_id) { user_printing[:id] }
      let(:slot) { 'deck' }

      it 'adds the card' do
        expect {
          service.perform(deck, slot, attrs)
        }.to change(deck.deck_cards_dataset.where(slot: slot), :count).by(1)
      end

      context 'when card exists' do
        before do
          service.perform(deck, slot, card_id: card[:id])
        end

        it 'does not add a card to deck' do
          expect {
            service.perform(deck, slot, attrs)
          }.to_not change(deck.deck_cards_dataset.where(slot: slot), :count)
        end

        it 'updates user printing on existing card' do
          ds = deck
            .deck_cards_dataset
            .where(slot: slot, user_printing_id: nil)

          expect {
            service.perform(deck, slot, attrs)
          }.to change { ds.count }.by(-1)
        end
      end

      context 'when card exists with same printing' do
        before do
          service.perform(deck, slot, attrs)
        end

        it 'does not add the card to deck' do
          expect {
            service.perform(deck, slot, attrs)
          }.to_not change(deck.deck_cards_dataset.where(slot: slot), :count)
        end
      end

      context 'when card exists with other printing' do
        before do
          other = Fabricate(:user_printing, printing: printing)

          service.perform(deck, slot,
                          card_id: card[:id],
                          user_printing_id: other[:id])
        end

        it 'adds the card to deck' do
          expect {
            service.perform(deck, slot, attrs)
          }.to change(deck.deck_cards_dataset.where(slot: slot), :count).by(1)
        end
      end

      context 'when card exists in scratchpad' do
        before do
          service.perform(deck, 'scratchpad', card_id: card[:id])
        end

        it 'adds a card to deck' do
          expect {
            service.perform(deck, slot, attrs)
          }.to change(deck.deck_cards_dataset.where(slot: slot), :count).by(1)
        end

        it 'removes a card from scratchpad' do
          expect {
            service.perform(deck, slot, attrs)
          }.to change(
            deck.deck_cards_dataset.where(slot: 'scratchpad'), :count
          ).by(-1)
        end
      end

      context 'when card exists in scratchpad with same printing' do
        before do
          service.perform(deck, 'scratchpad',
                          card_id: card[:id],
                          user_printing_id: user_printing[:id])
        end

        it 'adds a card to deck' do
          expect {
            service.perform(deck, slot, attrs)
          }.to change(deck.deck_cards_dataset.where(slot: slot), :count).by(1)
        end

        it 'removes a card from scratchpad' do
          expect {
            service.perform(deck, slot, attrs)
          }.to change(
            deck.deck_cards_dataset.where(slot: 'scratchpad'), :count
          ).by(-1)
        end
      end

      context 'when card exists in scratchpad with other printing' do
        before do
          other = Fabricate(:user_printing, printing: printing)

          service.perform(deck, 'scratchpad',
                          card_id: card[:id],
                          user_printing_id: other[:id])
        end

        it 'adds a card to deck' do
          expect {
            service.perform(deck, slot, attrs)
          }.to change(deck.deck_cards_dataset.where(slot: slot), :count).by(1)
        end

        it 'does not remove a card from scratchpad' do
          expect {
            service.perform(deck, slot, attrs)
          }.to_not change(
            deck.deck_cards_dataset.where(slot: 'scratchpad'), :count
          )
        end
      end
    end
  end
end
