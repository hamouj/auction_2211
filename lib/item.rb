class Item
  attr_reader :name, :bids

  def initialize(name)
    @name = name
    @bids = {}
    @accepting_bids = true
  end

  def add_bid(attendee, bid_amount)
    @bids[attendee] = bid_amount if @accepting_bids == true
  end

  def current_high_bid
    highest_bid_set = 
    @bids.max_by do |attendee, bid_amount|
      bid_amount
    end
    highest_bid = highest_bid_set[1]
  end

  def close_bidding
    @accepting_bids = false
  end
end