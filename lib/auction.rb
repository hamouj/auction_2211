require 'date'

class Auction
  attr_reader :items

  def initialize
    @items = []
    @date = Date.today.to_s.split('-')
  end

  def add_item(item)
    @items.push(item)
  end

  def item_names
    @items.map do |item|
      item.name
    end
  end

  def unpopular_items
    @items.select do |item|
      item.bids.empty?
    end
  end

  def potential_revenue
    potential_revenue = 0
    @items.each do |item|
      potential_revenue += item.current_high_bid if !item.bids.empty?
    end
    potential_revenue
  end

  def bidders
    bidders = []
    @items.each do |item|
      item.bids.each_key do |attendee|
        bidders << attendee
      end
    end
    bidders.uniq
  end

  def items_by_bidder(bidder)
    items_for_bidder = []
    @items.each do |item|
      item.bids.each_key do |attendee|
        items_for_bidder << item if attendee == bidder
      end
    end
    items_for_bidder
  end

  def bidder_info
    outer_hash = Hash.new {|hash, key| hash[key] = {}}
    inner_hash = Hash.new    

    bidders.each do |bidder|
      outer_hash[bidder]
      outer_hash[bidder][:budget] = bidder.budget
      outer_hash[bidder][:items] = items_by_bidder(bidder)
    end
    outer_hash
  end

  def date
    "#{@date[1]}/#{@date[2]}/#{@date[0]}"
  end
end