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

  describe '#add_item()' do
    it 'can add items' do
      auction.add_item(item1)
      auction.add_item(item2)

      expect(auction.items).to eq([item1, item2])
    end
  end

  describe '#item_names()' do
    it 'lists the names of the items' do
      auction.add_item(item1)
      auction.add_item(item2)

      expect(auction.item_names).to eq(["Chalkware Piggy Bank", "Bamboo Picture Frame"])
    end
  end

  describe '#add_bid()' do
    it 'adds bids to items' do
      auction.add_item(item1)
      auction.add_item(item2)
      auction.add_item(item3)
      auction.add_item(item4)
      auction.add_item(item5)

      item1.add_bid(attendee2, 20)
      item1.add_bid(attendee1, 22)

      expected_hash = {
        attendee2 => 20,
        attendee1 => 22
      }

      expect(item1.bids).to eq(expected_hash)
    end
  end

  describe '#current_high_bid' do
    it 'returns the current highest bid for the item' do
      auction.add_item(item1)
      auction.add_item(item2)
      auction.add_item(item3)
      auction.add_item(item4)
      auction.add_item(item5)

      item1.add_bid(attendee2, 20)
      item1.add_bid(attendee1, 22)

      expect(item1.current_high_bid).to eq(22)
    end
  end

  describe '#unpopular_items' do
    it 'lists items with no bids' do
      auction.add_item(item1)
      auction.add_item(item2)
      auction.add_item(item3)
      auction.add_item(item4)
      auction.add_item(item5)

      item1.add_bid(attendee2, 20)
      item1.add_bid(attendee1, 22)
      item4.add_bid(attendee3, 50)

      expect(auction.unpopular_items).to eq([item2, item3, item5])
      expect(auction.unpopular_items.size).to eq(3)
    end
  end

  describe '#potential_revenue' do
    it 'returns the total possible sale price of the items ' do
      auction.add_item(item1)
      auction.add_item(item2)
      auction.add_item(item3)
      auction.add_item(item4)
      auction.add_item(item5)

      item1.add_bid(attendee2, 20)
      item1.add_bid(attendee1, 22)
      item4.add_bid(attendee3, 50)
      item3.add_bid(attendee2, 15)

      expect(auction.potential_revenue).to eq(87)
    end
  end

  describe '#bidders' do
    it 'returns an array of attendees who have placed a bid in the auction' do
      auction.add_item(item1)
      auction.add_item(item2)
      auction.add_item(item3)
      auction.add_item(item4)
      auction.add_item(item5)

      item1.add_bid(attendee2, 20)
      item1.add_bid(attendee1, 22)
      item4.add_bid(attendee3, 50)
      item3.add_bid(attendee2, 15)

      expect(auction.bidders).to eq([attendee2, attendee1, attendee3])
    end
  end

  describe '#items_by_bidder()' do
    it 'lists items that a bidder has a put a bid in for' do
      auction.add_item(item1)
      auction.add_item(item2)
      auction.add_item(item3)
      auction.add_item(item4)
      auction.add_item(item5)

      item1.add_bid(attendee2, 20)
      item1.add_bid(attendee1, 22)
      item4.add_bid(attendee3, 50)
      item3.add_bid(attendee2, 15)

      expect(auction.items_by_bidder(attendee1)).to eq([item1])
      expect(auction.items_by_bidder(attendee2)).to eq([item1, item3])
      expect(auction.items_by_bidder(attendee3)).to eq([item4])
    end
  end
  
  describe '#bidder_info' do
    it 'returns a hash with keys that are attendees, and values that are a hash with that attendees budget and an array of items that attendee has bid on' do
      auction.add_item(item1)
      auction.add_item(item2)
      auction.add_item(item3)
      auction.add_item(item4)
      auction.add_item(item5)

      item1.add_bid(attendee2, 20)
      item1.add_bid(attendee1, 22)
      item4.add_bid(attendee3, 50)
      item3.add_bid(attendee2, 15)

      expected_hash = 
      {
        attendee1 =>
          {
            :budget => 50,
            :items => [item1]
          },
        attendee2 =>
          {
            :budget => 75,
            :items => [item1, item3]
          },
        attendee3 =>
          {
            :budget => 100,
            :items => [item4]
          }
      }

      expect(auction.bidder_info).to eq(expected_hash)
    end
  end

  describe '#date' do
    it 'returns a string representation of a past date' do
      allow(auction).to receive(:date).and_return('02/26/2022')
      expect(auction.date).to eq('02/26/2022')
    end

    it 'returns a string representation of the current date' do
      expect(auction.date).to include('2023')
    end
  end

  describe '#close_bidding' do
    it 'stops an item from accepting additional bids' do
      auction.add_item(item1)

      item1.add_bid(attendee2, 20)
      item1.add_bid(attendee1, 22)

      item1.close_bidding
      item1.add_bid(attendee3, 30)

      expected_hash = {
        attendee2 => 20,
        attendee1 => 22
      }

      expect(item1.bids).to eq(expected_hash)
    end
  end

  describe '#close_auction' do
    xit 'closes bidding and sells items to attendees' do
      auction.add_item(item1)
      auction.add_item(item2)
      auction.add_item(item3)
      auction.add_item(item4)
      auction.add_item(item5)

      item1.add_bid(attendee2, 20)
      item1.add_bid(attendee1, 22)
      item3.add_bid(attendee1, 15)
      item4.add_bid(attendee3, 50)
      item5.add_bid(attendee1, 25)
      item5.add_bid(attendee2, 20)

      expected_hash = {
        item1 => attendee1,
        item2 => 'Not Sold',
        item3 => attendee1,
        item4 => attendee3,
        item5 => attendee2
      }

      expect(auction.close_auction).to eq(expected_hash)
    end
  end
end