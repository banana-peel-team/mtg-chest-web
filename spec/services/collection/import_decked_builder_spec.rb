RSpec.describe Services::Collection::ImportDeckedBuilder do
  let(:service) { Services::Collection::ImportDeckedBuilder }
  let(:edition) { Fabricate(:edition) }

  let(:card1) { Fabricate(:card, name: 'Mountain') }
  let(:card2) { Fabricate(:card, name: 'Plains') }
  let(:printing1) { Fabricate(:printing, card: card1, edition: edition) }
  let(:printing2) { Fabricate(:printing, card: card2, edition: edition) }

  describe '.perform' do
    let(:contents) do
      "///mvid:#{printing1.multiverse_id} qty:3 name:Mountain\n" +
      "3 Mountain\n" +
      "///mvid:#{printing2.multiverse_id} qty:3 name:Plains\n" +
      "3 Plains\n"
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

      it 'returns correct data' do
        expect(perform).to match_array(
          [
            hash_including(
              count: 3,
              multiverse_id: printing1.multiverse_id,
              foil: false,
              condition: 'NM',
            ),
            hash_including(
              count: 3,
              multiverse_id: printing2.multiverse_id,
              foil: false,
              condition: 'NM',
            )
          ]
        )
      end
    end
  end
end
