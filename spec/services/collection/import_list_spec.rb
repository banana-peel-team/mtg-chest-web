RSpec.describe Services::Collection::ImportList do
  let(:service) { Services::Collection::ImportList }
  let(:edition) { Fabricate(:edition) }

  before do
    card1 = Fabricate(:card, name: 'Mountain')
    card2 = Fabricate(:card, name: 'Plains')
    Fabricate(:printing, card: card1, edition: edition)
    Fabricate(:printing, card: card2, edition: edition)
  end

  describe '.perform' do
    let(:list) { }
    let(:user) { Fabricate(:user) }
    let(:attrs) do
      {
        title: 'Import',
        edition_code: edition.code,
        foil: false,
        condition: 'NM',
        list: list.split("\n")
      }
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
