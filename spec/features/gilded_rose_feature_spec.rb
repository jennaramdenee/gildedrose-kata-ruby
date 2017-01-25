require File.join(File.dirname(__FILE__), '../../lib/gilded_rose')

describe GildedRose do

  describe "Simple scenarios" do

    it "reduces quality by 1 for a product that is still in date" do
      item = Item.new("foo", 5, 5)
      items = [item]
      GildedRose.new(items).update_quality()
      expect(item.quality).to eq 4
    end

    it "reduces sell_in date by 1 for a product that is still in date" do
      item = Item.new("foo", 5, 5)
      items = [item]
      GildedRose.new(items).update_quality()
      expect(item.sell_in).to eq 4
    end

  end

  describe "Past sell by date" do

    it "reduces quality by 2 for a product that is out of date" do
      item = Item.new("foo", 0, 5)
      items = [item]
      GildedRose.new(items).update_quality()
      expect(item.quality).to eq 3
    end

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

  describe "Quality cannot fall below 0" do

    it "never reduces quality below 0" do
      item = Item.new("foo", 1, 0)
      items = [item]
      GildedRose.new(items).update_quality()
      expect(item.quality).to eq 0
    end

  end

  describe "Aged Brie" do

    

    it "never increases quality over 50" do
      item = Item.new("Aged Brie", 1, 50)
      items = [item]
      GildedRose.new(items).update_quality()
      expect(item.quality).to eq 50
    end

  end

end
