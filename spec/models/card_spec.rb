RSpec.describe Card do
  subject(:model) { Card }

  context 'when two cards have a relation between them' do
    let!(:card_a) { Fabricate(:card) }
    let!(:card_b) { Fabricate(:card) }

    # Make sure this is true:
    #   left.id < right.id
    let(:ids) { [card_a[:id], card_b[:id]].sort }
    let(:card_left) { Card.first(id: ids[0]) }
    let(:card_right) { Card.first(id: ids[1]) }
    ####

    before do
      Fabricate(:card_relation,
                card_left: card_left,
                card_right: card_right,
                strength: Card::MIN_RELATION_STRENGTH + 1)
    end

    describe '.relations_to_left' do
      let(:card) { }
      let(:relations) { card.relations_to_left }

      context 'from right' do
        let(:card) { card_right }

        it 'is a relation to card_left' do
          expect(relations.first.card_left).to eq(card_left)
        end
      end

      context 'from left' do
        let(:card) { card_left }

        it 'has no relations' do
          expect(relations).to be_empty
        end
      end
    end

    describe '.relations_to_right' do
      let(:card) { }
      let(:relations) { card.relations_to_right }

      context 'from right' do
        let(:card) { card_right }

        it 'has no relations' do
          expect(relations).to be_empty
        end
      end

      context 'from left' do
        let(:card) { card_left }

        it 'is a relation to card_right' do
          expect(relations.first.card_right).to eq(card_right)
        end
      end
    end

    describe '.related_cards_to_left' do
      let(:card) { }
      let(:relations) { card.related_cards_to_left }

      context 'from right' do
        let(:card) { card_right }

        it 'contains the card_left' do
          expect(relations).to include(card_left)
        end
      end

      context 'from left' do
        let(:card) { card_left }

        it 'has no relations' do
          expect(relations).to be_empty
        end
      end
    end

    describe '.related_cards_to_right' do
      let(:card) { }
      let(:relations) { card.related_cards_to_right }

      context 'from right' do
        let(:card) { card_right }

        it 'has no relations' do
          expect(relations).to be_empty
        end
      end

      context 'from left' do
        let(:card) { card_left }

        it 'contains the card_right' do
          expect(relations).to include(card_right)
        end
      end
    end

    describe '.related_cards' do
      let(:card) { }
      let(:relations) { card.related_cards }

      context 'from right' do
        let(:card) { card_right }

        it 'contains the card_left' do
          expect(relations).to include(card_left)
        end
      end

      context 'from left' do
        let(:card) { card_left }

        it 'contains the card_right' do
          expect(relations).to include(card_right)
        end
      end
    end
  end
end
