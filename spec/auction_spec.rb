require './lib/item'
require './lib/attendee'
require './lib/auction'

describe Auction do
  let(:item1) {Item.new('Chalkware Piggy Bank')}
  let(:item2) {Item.new('Bamboo Picture Frame')}
  let(:attendee) {Attendee.new(name: 'Megan', budget: '$50')}
  let(:auction) {Auction.new}

  describe '#initialize' do
    it 'exists' do
      expect(auction).to be_a(Auction)
    end

    it 'starts with no items' do
      expect(auction.items).to eq([])
    end
  end

  describe '#add_items' do
    it 'can add items' do
      auction.add_item(item1)
      auction.add_item(item2)

      expect(auction.items).to eq([item1, item2])
    end
  end
end