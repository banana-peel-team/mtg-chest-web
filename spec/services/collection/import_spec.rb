RSpec.describe Services::Collection::Import do
  let(:service) { Services::Collection::Import }
  let(:edition) { Fabricate(:edition) }

  let(:card1) { Fabricate(:card, name: 'Mountain') }
  let(:card2) { Fabricate(:card, name: 'Plains') }
  let(:printing1) { Fabricate(:printing, card: card1, edition: edition) }
  let(:printing2) { Fabricate(:printing, card: card2, edition: edition) }

  describe '.perform' do
    let(:contents) do
      "Name,Edition,Foil,Condition,Count\n" +
      "Mountain,#{printing1.edition.name},,Near Mint,3\n" +
      "Plains,#{printing2.edition.name},,Near Mint,3\n"
    end

    let(:file) { StringIO.new(contents) }
    let(:user) { Fabricate(:user) }
    let!(:import) { Fabricate(:import) }

    let(:attrs) do
      {
        source: 'deckbox',
        title: 'Test import',
        file: 'deckbox-file',
      }
    end

    before do
      # TODO: Improve?
      allow(File)
        .to receive(:open).with('deckbox-file', 'rb').and_yield(file)
    end

    subject(:perform) { service.perform(user, attrs) }

    context 'with a valid list' do
      let(:list) do
        ["3 Mountain",
         "3 Plains"].join("\n")
      end

      it 'creates an Import' do
        expect {
          perform
        }.to change(Import, :count).by(1)
      end

      it 'creates 6 UserPrinting' do
        expect {
          perform
        }.to change(UserPrinting, :count).by(6)
      end
    end
  end
end
