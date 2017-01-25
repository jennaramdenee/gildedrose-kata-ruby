class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      if item.name != "Sulfuras, Hand of Ragnaros"

        if in_date?(item)

          #Normal items
          if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"

            if !negative_quality?(item, -1)
              update_quality2(item, -1)
            else
              set_quality(item, 0)
            end

          else

            #Brie
            if item.name == "Aged Brie"
              if !over_quality?(item, 1)
                update_quality2(item, 1)
              else
                set_quality(item, 50)
              end
            end

            #Backstage
            if item.name == "Backstage passes to a TAFKAL80ETC concert"

              if item.sell_in < 6
                if !over_quality?(item, 3)
                  update_quality2(item, 3)
                end

              elsif item.sell_in < 11
                if !over_quality?(item, 2)
                  update_quality2(item, 2)
                end

              end


            end

          end
        else
          update_quality2(item, -2)
        end
        update_sell_in(item)

      end
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
