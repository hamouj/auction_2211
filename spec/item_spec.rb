require './lib/item'

describe Item do
  let(:item1) {Item.new('Chalkware Piggy Bank')}

  describe '#initialize' do
    it 'exists' do
      expect(item1).to be_a(Item)
    end

    it 'has a name' do
      expect(item1.name).to eq("Chalkware Piggy Bank")
    end
  end
end