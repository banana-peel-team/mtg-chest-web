RSpec.describe Services::Collection::ImportMTGManager do
  let(:service) { Services::Collection::ImportMTGManager }
  let(:edition) { Fabricate(:edition) }

  let(:card1) { Fabricate(:card, name: 'Mountain') }
  let(:card2) { Fabricate(:card, name: 'Plains') }
  let(:printing1) { Fabricate(:printing, card: card1, edition: edition) }
  let(:printing2) { Fabricate(:printing, card: card2, edition: edition) }

  describe '.perform' do
    let(:contents) do
      "Name,Code,Foil,Condition,Quantity,PurchaseDate\n" +
      "Mountain,#{printing1.edition_code},,0,3,#{Time.now.utc}\n" +
      "Plains,#{printing2.edition_code},,0,3,#{Time.now.utc}\n"
    end

    let(:file) { StringIO.new(contents) }
    let!(:import) { Fabricate(:import) }
    let(:user) { Fabricate(:user) }

    subject(:perform) { service.perform(import, user, file) }

    context 'with a valid list' do
      let(:list) do
        ["3 Mountain",
         "3 Plains"].join("\n")
      end

      it 'does not create an Import' do
        expect {
          perform
        }.to_not change(Import, :count)
      end

      it 'creates 6 UserPrinting' do
        expect {
          perform
        }.to change(UserPrinting, :count).by(6)
      end
    end
  end
end
