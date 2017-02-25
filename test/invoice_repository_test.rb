require 'minitest/autorun'
require 'minitest/pride'
require_relative './../lib/sales_engine'


class InvoiceRepositoryTest < Minitest::Test
  attr_reader :se

  def setup
    @se = SalesEngine.from_csv({:items => "./data/items.csv", :merchants => "./data/merchants.csv", :invoices => "./test/fixtures/invoices_truncated.csv"})

  end

  def test_it_exists
    assert_instance_of InvoiceRepository, se.invoices
  end

  def test_it_returns_all_known_invoices
    assert_equal 99, se.invoices.all.count
  end

  def test_it_finds_by_id
    invoice = se.invoices.all.first

    assert_equal invoice, se.invoices.find_by_id(1)
    assert_nil se.invoices.find_by_id(-1)
  end

  def test_it_finds_all_by_customer_id
    assert_equal 8, se.invoices.find_all_by_customer_id(1).count
    assert_instance_of Invoice, se.invoices.find_all_by_customer_id(1).first
  end

  def test_it_finds_all_by_merchant_id
    assert_equal 2, se.invoices.find_all_by_merchant_id(12335955).count
    assert_equal [], se.invoices.find_all_by_merchant_id(-1)
    assert_instance_of Invoice, se.invoices.find_all_by_merchant_id(12335955).first
    #returns either [] or one or more matches which have a matching merchant ID
  end

  def test_it_finds_all_by_status
    assert_equal 62, se.invoices.find_all_by_status("shipped").count
    assert_equal 8, se.invoices.find_all_by_status("returned").count
    assert_equal 29, se.invoices.find_all_by_status("pending").count
    assert_instance_of Invoice, se.invoices.find_all_by_status("returned").first

    # returns either [] or one or more matches which have a matching status
  end

end
