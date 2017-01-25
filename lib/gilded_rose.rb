class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|

      if in_date?(item)

        if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"

          if !negative_quality?(item, -1)
            if item.name != "Sulfuras, Hand of Ragnaros"
              update_quality2(item, -1)
            end

          end

        else
            #All about backstage
            if item.name == "Backstage passes to a TAFKAL80ETC concert"
              if item.sell_in < 11

                if !over_quality?(item)
                  update_quality2(item, 1)
                end

              end

              if item.sell_in < 6
                if item.quality < 50
                  update_quality2(item, 1)
                end
              end

            end
        end
      else
        update_quality2(item, -2)
      end

      #Exceptions
      if item.name != "Sulfuras, Hand of Ragnaros"
        update_sell_in(item)
      end
      #
      #
      #   # if item.name != "Aged Brie"
      #   #   set_quality(item, 0)
      #   # else
      #     #All about brie
      #     if item.quality < 50
      #       update_quality2(item, -1)
      #     end
      #   # end
      # end
    end


  end

  def negative_quality?(item, value)
    item.quality + value < 0
  end

  def over_quality?(item, value)
    item.quality + value > 50
  end

  def update_quality2(item, value)
    item.quality += value
  end

  def in_date?(item)
    item.sell_in > 0
  end

  def update_sell_in(item)
    item.sell_in -= 1
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
