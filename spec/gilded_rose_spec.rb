require File.join(File.dirname(__FILE__), '../lib/gilded_rose')

describe GildedRose do

  describe "#update_quality" do

    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    it "returns true when quality will be reduced below zero" do
      item = Item.new("foo", 0, 0)
      rose = GildedRose.new(item)
      expect(rose.negative_quality?(item, -1)).to eq true
    end

    it "returns false when quality will not be reduced below zero" do
      item = Item.new("foo", 0, 3)
      rose = GildedRose.new(item)
      expect(rose.negative_quality?(item, -1)).to eq false
    end

    it "returns true when quality will be increased above fifty" do
      item = Item.new("foo", 0, 0)
      rose = GildedRose.new(item)
      expect(rose.over_quality?(item, 49)).to eq false
    end

    it "returns false when quality will not be increased above fifty" do
      item = Item.new("foo", 0, 1)
      rose = GildedRose.new(item)
      expect(rose.over_quality?(item, 50)).to eq true
    end

    it "can amend quality for an item by a given positive value" do
      item = Item.new("foo", 0, 1)
      rose = GildedRose.new(item)
      rose.update_quality2(item, 4)
      expect(item.quality).to eq 5
    end

    it "can amend quality for an item by a given negative value" do
      item = Item.new("foo", 0, 5)
      rose = GildedRose.new(item)
      rose.update_quality2(item, -3)
      expect(item.quality).to eq 2
    end

    it "can check whether product is still in date" do
      item = Item.new("foo", 0, 0)
      rose = GildedRose.new(item)
      expect(rose.in_date?(item)).to eq true
    end

    it "can check whether a product is out of date" do
      item = Item.new("foo", -2, 0)
      rose = GildedRose.new(item)
      expect(rose.in_date?(item)).to eq false
    end

    it "can amend sell by date for an item" do
      item = Item.new("foo", 3, 0)
      rose = GildedRose.new(item)
      rose.update_sell_in(item)
      expect(item.sell_in).to eq 2
    end

  end

end
