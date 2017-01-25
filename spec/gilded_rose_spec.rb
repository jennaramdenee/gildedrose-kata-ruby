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
      expect(rose.negative_quality?(item, 1)).to eq true
    end

    it "returns false when quality will not be reduced below zero" do
      item = Item.new("foo", 0, 3)
      rose = GildedRose.new(item)
      expect(rose.negative_quality?(item, 1)).to eq false
    end

  end

end
