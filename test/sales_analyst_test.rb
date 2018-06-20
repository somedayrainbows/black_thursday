require_relative 'test_helper'
require_relative './../lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  attr_reader :sa,
              :se

  def setup
    @se = $sales_engine
    @sa = SalesAnalyst.new(se)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, sa
  end

  def test_it_returns_average_items_per_merchant
    assert_equal 2.61, sa.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation
    assert_equal 2.82, sa.average_items_per_merchant_standard_deviation
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
    assert_equal 16413289.92, sa.find_standard_deviation(collection)
  end

  def test_it_can_determine_the_standard_deviation_of_average_invoices_per_merchant
    assert_equal 0.38, sa.average_invoices_per_merchant_standard_deviation
  end

  def test_it_can_find_top_merchants_by_invoice_count
    assert_equal 12, sa.top_merchants_by_invoice_count.count
    assert_instance_of Merchant, sa.top_merchants_by_invoice_count.first
  end

  def test_it_can_find_averages
    ary = [1,5,9]
    assert_equal 5, sa.find_average(ary)
  end

  def test_it_can_find_bottom_merchants_by_invoice_count
    assert_equal 2, sa.bottom_merchants_by_invoice_count.count
    assert_instance_of Merchant, sa.bottom_merchants_by_invoice_count.first
  end

  def test_it_can_determine_the_day_an_entry_was_created
    assert_equal "Thursday", sa.find_day(se.merchants.all.first)
  end

  def test_it_can_count_how_many_entries_were_built_on_each_day
    set = se.invoices.all
    assert_equal 12, sa.find_entries_for_each_day(set)['Thursday']
  end

  def test_it_can_create_an_array_of_total_entries_for_each_day
    set = sa.find_entries_for_each_day(se.invoices.all)
    assert_equal 7, sa.calculate_total_daily_entries(set).count
  end

  def test_it_can_find_the_standard_deviation_of_daily_entries
    set = sa.calculate_total_daily_entries(sa.find_entries_for_each_day(se.invoices.all))
    assert_equal 3.39, sa.find_standard_deviation(set)
  end

  def test_it_can_determine_days_of_week_with_most_sales
    assert_equal ["Friday"], sa.top_days_by_invoice_count
  end

  def test_it_can_determine_percentage_of_invoices_by_status
    assert_equal 29.29, sa.invoice_status(:pending)
    assert_equal 62.63, sa.invoice_status(:shipped)
    assert_equal 8.08, sa.invoice_status(:returned)
  end

  def test_it_knows_which_merchant_a_customer_bought_the_most_items_from
    customer = se.customers.find_by_id(1)
    merchant = customer.merchants[2]

    assert_equal merchant, sa.top_merchant_for_customer(1)
  end

  def test_it_knows_which_customers_only_had_one_invoice
    one_time_buyers = sa.one_time_buyers

    assert_equal 2, one_time_buyers.count
    assert_instance_of Customer, one_time_buyers.sample
  end

  def test_it_knows_the_items_a_one_time_buyer_bought
    one_time_buyers_items = sa.one_time_buyers_items

    assert_equal 1, one_time_buyers_items.size
    assert_instance_of Item, one_time_buyers_items.sample
  end

  def test_return_customers_that_spent_the_most
    assert_equal 5, sa.top_buyers(5).count
    assert_equal 20, sa.top_buyers.count
    assert_instance_of Customer, sa.top_buyers(5).sample
  end

  def test_identifies_a_customers_highest_value_items
    items = sa.highest_volume_items(1)

    assert_equal 2, items.count
    assert_instance_of Item, items.sample
  end

  def test_returns_invoices_with_highest_item_count
    invoice = sa.best_invoice_by_quantity

    assert_equal 32, invoice.id
  end

  def test_best_invoice_by_revenue
    invoice = sa.best_invoice_by_revenue

    assert_equal 73, invoice.id
    assert_equal 38500.84, invoice.total
  end

  def test_it_reports_unpaid_customers
    customers = sa.customers_with_unpaid_invoices

    assert_equal 17, customers.count
    assert_instance_of Customer, customers.sample
  end

 def test_it_returns_a_customers_purchased_items_in_a_given_year
   assert_equal 263519844, sa.items_bought_in_year(1, 2009).first.id

   assert_instance_of Item,
    sa.items_bought_in_year(1, 2009).first

   assert_equal 8, sa.items_bought_in_year(1, 2009).count
 end
end
