RSpec.describe Services::Collection::DeleteImport do
  let(:service) { Services::Collection::DeleteImport }

  describe '.perform' do
    let(:import) { Fabricate(:import) }
    subject(:perform) { service.perform(import) }

    context 'when contains cards in decks' do
      let(:user_printing) { Fabricate(:user_printing, import: import) }

      before do
        Fabricate(:deck_card, user_printing: user_printing)
      end

      it 'deletes the import' do
        expect {
          perform
        }.to change(Import, :count).by(-1)
      end

      context 'when other cards point to other imports' do
        let(:other_user_printing) { Fabricate(:user_printing) }
        let!(:other_deck_card) do
          Fabricate(:deck_card, user_printing: other_user_printing)
        end

        it 'does not change the other deck card' do
          perform
          other_deck_card.reload

          expect(other_deck_card.user_printing_id)
            .to eq(other_user_printing.id)
        end
      end
    end
  end
end
