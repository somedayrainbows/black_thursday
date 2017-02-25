require 'pry'

class SalesAnalyst
  attr_reader :se, :avg_items_per_merchant, :avg_items_per_merchant_standard_deviation

  def initialize(sales_engine)
    @se = sales_engine
    @avg_items_per_merchant = average_items_per_merchant
    @avg_items_per_merchant_standard_deviation = average_items_per_merchant_standard_deviation
  end

  def average_items_per_merchant
    (se.items.all.count.to_f / se.merchants.all.count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    avg = se.items.all.count.to_f / se.merchants.all.count.to_f

    squared_diffs = se.merchants.all.map do |merchant|
      (merchant.items.count - avg) ** 2
    end.reduce(:+)
    std_dev = Math.sqrt(squared_diffs / (se.merchants.all.count - 1)).round(2)
  end

  def merchants_with_high_item_count
    se.merchants.all.select do |merchant|
      merchant.items.count > avg_items_per_merchant + avg_items_per_merchant_standard_deviation
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = se.merchants.find_by_id(merchant_id)
    total = merchant.items.reduce(0) do |sum, item|
      sum += item.unit_price
    end
    total / merchant.items.count
  end

  def average_average_price_per_merchant
    total = se.merchants.all.reduce(0) do |sum, merchant|
      sum += average_item_price_for_merchant(merchant.id)
    end
    total / se.merchants.all.count
  end

  def golden_items
    total = se.items.all.reduce(0) do |sum, item|
      sum += item.unit_price
    end
    average_item_price = total / se.items.all.count

    # Refactor, test separately, test for inclusion of averge_item_price
    squared_diffs = se.items.all.map do |item|
      (item.unit_price - average_item_price) ** 2
    end.reduce(:+)
    std_dev = Math.sqrt(squared_diffs / (se.items.all.count - 1)).round(2)

    se.items.all.select do |item|
      item.unit_price > (std_dev * 2) + average_item_price
    end
  end
end
