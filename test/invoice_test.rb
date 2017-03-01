require_relative 'test_helper'
require_relative './../lib/invoice'

class InvoiceTest < Minitest::Test
  attr_reader :invoice, :se

  def setup
    @se = $sales_engine
    @invoice = Invoice.new('./test/fixtures/invoices_truncated.csv', nil)
  end

  def test_it_exists
    assert_instance_of Invoice, invoice
  end

  def test_it_knows_its_ids
    assert_equal 1, invoice.id
    assert_equal 1, invoice.customer_id
    assert_equal 12335938, invoice.merchant_id
  end

  def test_it_knows_its_details
    assert_equal :pending, invoice.status
    assert_equal Time.new(2009, 02, 07), invoice.created_at
    assert_equal Time.new(2014, 03, 15), invoice.updated_at
  end

  def test_it_can_find_its_merchant
    invoice = se.invoices.find_by_id(20)

    assert_instance_of Merchant, invoice.merchant
  end

  def test_it_can_find_its_id_through_sales_engine
    invoice = se.invoices.find_by_id(20)

    assert_instance_of Item, invoice.items.sample
    # invoice.items => [item, item, item]
  end

end
