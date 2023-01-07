require './lib/item'
require './lib/attendee'
require './lib/auction'

describe Auction do
  let(:item1) {Item.new('Chalkware Piggy Bank')}
  let(:item2) {Item.new('Bamboo Picture Frame')}
  let(:item3) {Item.new('Homemade Chocolate Chip Cookies')}
  let(:item4) {Item.new('2 Days Dogsitting')}
  let(:item5) {Item.new('Forever Stamps')}

  let(:attendee1) {Attendee.new(name: 'Megan', budget: '$50')}
  let(:attendee2) {Attendee.new(name: 'Bob', budget: '$75')}
  let(:attendee3) {Attendee.new(name: 'Mike', budget: '$100')}

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

  describe '#item_names' do
    it 'lists the names of the items' do
      auction.add_item(item1)
      auction.add_item(item2)

      expect(auction.item_names).to eq(["Chalkware Piggy Bank", "Bamboo Picture Frame"])
    end
  end

  describe '#add_bid' do
    it 'adds bids to items' do
      auction.add_item(item1)
      auction.add_item(item2)
      auction.add_item(item3)
      auction.add_item(item4)
      auction.add_item(item5)

      item1.add_bid(attendee2, 20)
      item1.add_bid(attendee1, 22)

      expected_hash = {
        attendee2 => 20
        attendee1 => 22
      }

      expect(item1.bids).to eq(expected_hash)
    end
  end
end