require 'minitest/autorun'
require 'minitest/pride'
require_relative './../lib/sales_engine'
require_relative './../lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  attr_reader :sa, :se

  def setup
    @se = SalesEngine.from_csv({:items => "./data/items.csv", :merchants => "./data/merchants.csv"})
    @sa = SalesAnalyst.new(se)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, sa
  end

  def test_it_returns_average_items_per_merchant
    assert_equal 2.88, sa.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation
    assert_equal 3.26, sa.average_items_per_merchant_standard_deviation
  end

  def test_it_identifies_whales
    assert_equal 52, sa.merchants_with_high_item_count.length
    assert_includes sa.merchants_with_high_item_count, se.merchants.find_by_id(12334123)
  end

  def test_it_identifies_average_item_price_per_merchant
    assert_instance_of BigDecimal, sa.average_item_price_for_merchant(12334123)
    assert_equal 100.0, sa.average_item_price_for_merchant(12334123).to_f
  end

  def test_it_identifies_average_item_price_per_merchant_average
    assert_equal 350.29, sa.average_average_price_per_merchant.to_f.round(2)
  end


  def test_it_can_find_golden_items
    assert_equal 5, sa.golden_items.count
    assert_instance_of Item, sa.golden_items.sample
  end

end
