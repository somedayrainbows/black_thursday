require 'minitest/autorun'
require 'minitest/pride'
require_relative './../lib/sales_engine'
require_relative './../lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  attr_reader :sa, :se

  def setup
    @se = SalesEngine.from_csv({:items => "./test/fixtures/items_truncated.csv", :merchants => "./test/fixtures/merchants_truncated.csv", :invoices => "./test/fixtures/invoices_truncated.csv"})
    @sa = SalesAnalyst.new(se)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, sa
  end

  def test_it_returns_average_items_per_merchant
    assert_equal 2.55, sa.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation
    assert_equal 2.87, sa.average_items_per_merchant_standard_deviation
  end

  def test_it_identifies_whales
    assert_equal 10, sa.merchants_with_high_item_count.length

    assert_includes sa.merchants_with_high_item_count, se.merchants.find_by_id(12334365)
  end

  def test_it_identifies_average_item_price_per_merchant
    assert_instance_of BigDecimal, sa.average_item_price_for_merchant(12334365)
    assert_equal 42.99, sa.average_item_price_for_merchant(12334365).to_f
  end

  def test_it_identifies_average_item_price_per_merchant_average
    assert_equal 2809174.15, sa.average_average_price_per_merchant.to_f.round(2)
  end


  def test_it_can_find_golden_items
    assert_equal 1, sa.golden_items.count
    assert_instance_of Item, sa.golden_items.sample
  end

  def test_it_can_determine_the_number_of_average_invoices_per_merchant
    assert_equal 1.11, sa.average_invoices_per_merchant
  end

  def test_it_can_calculate_standard_deviation
    collection = se.items.all.map { |item| item.unit_price }
    assert_equal 16593068.75, sa.standard_deviation(collection)
  end

  def test_it_can_determine_the_standard_deviation_of_average_invoices_per_merchant
    assert_equal 0.4, sa.average_invoices_per_merchant_standard_deviation
  end

  def test_it_can_find_averages
    ary = [1,5,9]
    assert_equal 5, sa.find_average(ary)
  end

end
