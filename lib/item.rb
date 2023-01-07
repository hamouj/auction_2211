class Item
  attr_reader :name, :bids

  def initialize(name)
    @name = name
    @bids = {}
  end

  def add_bid(attendee, bid_amount)
    @bids[attendee] = bid_amount
  end

  def current_high_bid
    highest_bid_set = 
    @bids.max_by do |attendee, bid_amount|
      bid_amount
    end
    highest_bid = highest_bid_set[1]
  end
end