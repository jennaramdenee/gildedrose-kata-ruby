require File.join(File.dirname(__FILE__), '../../lib/gilded_rose')

describe GildedRose do

  describe "Past sell by date" do

    it "reduces sell_in date for 1 for a product that is out of date" do
      item = Item.new("foo", 0, 5)
      items = [item]
      GildedRose.new(items).update_quality()
      expect(item.sell_in).to eq -1
    end

  end

  describe "Sulfuras" do

    it "never reduces the quality" do
      item = Item.new("Sulfuras, Hand of Ragnaros", 0, 80)
      items = [item]
      GildedRose.new(items).update_quality()
      expect(item.quality).to eq 80
    end

    it "never reduces the sell_in date" do
      item = Item.new("Sulfuras, Hand of Ragnaros", 0, 80)
      items = [item]
      GildedRose.new(items).update_quality()
      expect(item.sell_in).to eq 0
    end

  end

end
