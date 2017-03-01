require_relative 'test_helper'

class InvoiceTest < Minitest::Test
  attr_reader :invoice

  def setup
    @invoice = Invoice.new('./test/fixtures/invoices_truncated.csv', $sales_engine)
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
    assert_instance_of Merchant, invoice.merchant
  end

  def test_it_returns_an_array_of_related_item_objects
    assert_instance_of Item, invoice.items.sample
  end

  def test_returns_an_array_of_related_transaction_objects
    assert_instance_of Transaction, invoice.transactions.sample
  end

  def test_returns_a_related_customer_object
    assert_instance_of Customer, invoice.customer
    # =>  customer
  end

end
