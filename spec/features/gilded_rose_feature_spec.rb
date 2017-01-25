require File.join(File.dirname(__FILE__), '../../lib/gilded_rose')

describe GildedRose do

  describe "Product specific scenarios" do

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

end
