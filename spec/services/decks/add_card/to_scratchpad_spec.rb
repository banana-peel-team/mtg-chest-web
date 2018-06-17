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

    context 'adding card to scratchpad' do
      let(:slot) { 'scratchpad' }

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

      context 'when card exists with a printing' do
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
    end

    context 'adding card to scratchpad with printing' do
      let(:user_printing_id) { user_printing[:id] }
      let(:slot) { 'scratchpad' }

      it 'adds the card' do
        expect {
          service.perform(deck, slot, attrs)
        }.to change(deck.deck_cards_dataset.where(slot: slot), :count).by(1)
      end

      context 'when card already on scratchpad' do
        before do
          service.perform(deck, slot, card_id: card[:id])
        end

        it 'does not add a card to scratchpad' do
          expect {
            service.perform(deck, slot, attrs)
          }.to_not change(
            deck.deck_cards_dataset.where(slot: slot), :count
          )
        end

        it 'updates user printing on existing card' do
          ds = deck
            .deck_cards_dataset
            .where(slot: slot, user_printing_id: nil)

          expect {
            service.perform(deck, slot, attrs)
          }.to change { ds.count }.by(-1)
        end

        context 'and a card with other printing exists' do
          before do
            other = Fabricate(:user_printing, printing: printing)

            service.perform(deck, slot,
                            card_id: card[:id],
                            user_printing_id: other[:id])
            service.perform(deck, slot, card_id: card[:id])
          end

          it 'updates user printing on existing card' do
            ds = deck
              .deck_cards_dataset
              .where(slot: slot, user_printing_id: nil)

            expect {
              service.perform(deck, slot, attrs)
            }.to change { ds.count }.by(-1)
          end

          it 'does not add a card to scratchpad' do
            expect {
              service.perform(deck, slot, attrs)
            }.to_not change(
              deck.deck_cards_dataset.where(slot: slot), :count
            )
          end
        end
      end

      context 'when card exists with same printing' do
        before do
          service.perform(deck, slot, attrs)
        end

        it 'does not add the card' do
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

        it 'adds the card' do
          expect {
            service.perform(deck, slot, attrs)
          }.to change(deck.deck_cards_dataset.where(slot: slot), :count).by(1)
        end
      end
    end
  end
end
