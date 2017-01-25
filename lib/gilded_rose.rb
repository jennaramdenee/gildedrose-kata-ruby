class GildedRose

  QUALITY_REDUCTION = 1
  SELL_IN_REDUCTION = 1
  MAX_QUALITY = 50
  MIN_QUALITY = 0

  def initialize(items)
    @items = items
  end

  def calculate_quality
    @items.each do |item|
      if item.name == "Sulfuras, Hand of Ragnaros"
        break
      elsif item.name == "Aged Brie"
        calculate_brie_quality(item)
      elsif item.name == "Backstage passes to a TAFKAL80ETC concert"
        calculate_backstage_passes_quality(item)
      elsif item.name.include?("Conjured")
        calculate_conjured_quality(item)
      else
        calculate_non_exceptions_quality(item)
      end
      update_sell_in(item)
    end
  end

  def calculate_non_exceptions_quality(item)
    if in_date?(item)
      update_quality(item, -QUALITY_REDUCTION)
    else
      update_quality(item, -(QUALITY_REDUCTION*2))
    end
  end

  def calculate_backstage_passes_quality(item)
    if in_date?(item)
      if item.sell_in < 6
        update_quality(item, 3)
      else item.sell_in < 11
        update_quality(item, 2)
      end
    else
      set_quality(item, MIN_QUALITY)
    end
  end

  def calculate_brie_quality(item)
    update_quality(item, QUALITY_REDUCTION)
  end

  def calculate_conjured_quality(item)
    if in_date?(item)
      update_quality(item, -(QUALITY_REDUCTION*2))
    else
      update_quality(item, -(QUALITY_REDUCTION*4))
    end
  end

  def negative_quality?(item, value)
    item.quality + value < 0
  end

  def over_quality?(item, value)
    item.quality + value > MAX_QUALITY
  end

  def update_quality(item, value)
    if value > 0
      !over_quality?(item, value) ? item.quality += value : set_quality(item, MAX_QUALITY)
    else
      !negative_quality?(item, value) ? item.quality += value : set_quality(item, MIN_QUALITY)
    end
  end

  def in_date?(item)
    item.sell_in > 0
  end

  def update_sell_in(item)
    item.sell_in -= SELL_IN_REDUCTION
  end

  def set_quality(item, value)
    item.quality = value
  end

end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
