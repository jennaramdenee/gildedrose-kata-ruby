require File.join(File.dirname(__FILE__), '../lib/gilded_rose')

describe GildedRose do

  describe "#initialize" do

    it "initializes with a constant value by which quality is reduced" do
      expect(GildedRose::QUALITY_REDUCTION).to eq 1
    end

    it "initializes with a constant value by which sell_in is reduced" do
      expect(GildedRose::SELL_IN_REDUCTION).to eq 1
    end

    it "initializes with a constant value which quality cannot exceed" do
      expect(GildedRose::MAX_QUALITY).to eq 50
    end

    it "initializes with a constant value which quality cannot fall below" do
      expect(GildedRose::MIN_QUALITY).to eq 0
    end

  end

  describe "#update_quality" do

    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

  end

  describe "#negative_quality?" do

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

  end

  describe "#over_quality?" do

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

  end

  describe "#update_quality2" do

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

    it "never reduces quality below zero" do
      item = Item.new("foo", 1, 0)
      rose = GildedRose.new(item)
      rose.update_quality2(item, -3)
      expect(item.quality).to eq 0
    end

    it "never increases quality above fifty" do
      item = Item.new("foo", 1, 50)
      rose = GildedRose.new(item)
      rose.update_quality2(item, 5)
      expect(item.quality).to eq 50
    end

  end

  describe "#in_date?" do

    it "can check whether product is still in date" do
      item = Item.new("foo", 1, 0)
      rose = GildedRose.new(item)
      expect(rose.in_date?(item)).to eq true
    end

    it "can check whether a product is out of date" do
      item = Item.new("foo", -2, 0)
      rose = GildedRose.new(item)
      expect(rose.in_date?(item)).to eq false
    end

  end

  describe "#update_sell_in" do

    it "can amend sell by date for an item" do
      item = Item.new("foo", 3, 0)
      rose = GildedRose.new(item)
      rose.update_sell_in(item)
      expect(item.sell_in).to eq 2
    end


    it "reduces sell_in date by 1 for a product that is still in date" do
      item = Item.new("foo", 5, 5)
      rose = GildedRose.new(item)
      rose.update_sell_in(item)
      expect(item.sell_in).to eq 4
    end

  end

  describe "#set_quality" do

    it "can set item quality to a defined value" do
      item = Item.new("foo", 0, 0)
      rose = GildedRose.new(item)
      rose.set_quality(item, 6)
      expect(item.quality).to eq 6
    end

  end

  describe "#calculate_brie_quality" do

    it "increases quality at the end of the day" do
      item = Item.new("Aged Brie", 1, 33)
      rose = GildedRose.new(item)
      rose.calculate_brie_quality(item)
      expect(item.quality).to eq 34
    end

    it "never increases quality over fifty" do
      item = Item.new("Aged Brie", 1, 50)
      rose = GildedRose.new(item)
      rose.calculate_brie_quality(item)
      expect(item.quality).to eq 50
    end

  end

  describe "#calculate_backstage_passes_quality" do

    it "increases quality by 2 if there are 9 days until sell_in date" do
      item = Item.new("Backstage passes to a TAFKAL80ETC concert", 9, 40)
      rose = GildedRose.new(item)
      rose.calculate_backstage_passes_quality(item)
      expect(item.quality).to eq 42
    end

    it "increases quality by 3 if there are 4 days until sell_in date" do
      item = Item.new("Backstage passes to a TAFKAL80ETC concert", 4, 30)
      rose = GildedRose.new(item)
      rose.calculate_backstage_passes_quality(item)
      expect(item.quality).to eq 33
    end

    it "sets quality to 0 after the concert" do
      item = Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 30)
      rose = GildedRose.new(item)
      rose.calculate_backstage_passes_quality(item)
      expect(item.quality).to eq 0
    end

    it "never increases quality over fifty" do
      item = Item.new("Backstage passes to a TAFKAL80ETC concert", 4, 49)
      rose = GildedRose.new(item)
      rose.calculate_backstage_passes_quality(item)
      expect(item.quality).to eq 50
    end

  end

  describe "#calculate_non_exceptions_quality" do

    it "reduces quality by 1 for a product that is still in date" do
      item = Item.new("foo", 5, 5)
      rose = GildedRose.new(item)
      rose.calculate_non_exceptions_quality(item)
      expect(item.quality).to eq 4
    end

    it "reduces quality by 2 for a product that is out of date" do
      item = Item.new("foo", 0, 5)
      items = [item]
      GildedRose.new(items).update_quality()
      expect(item.quality).to eq 3
    end

  end


end
