require_relative 'test_helper'

class SalesEngineTest < Minitest::Test
  attr_reader :se

  def setup
    @se = $sales_engine
  end

  def test_it_can_return_instance_of_merchants
    assert_instance_of MerchantRepository, se.merchants
  end

  def test_it_can_return_instance_of_items
    assert_instance_of ItemRepository, se.items
  end

  def test_it_can_return_instance_of_invoices
    assert_instance_of InvoiceRepository, se.invoices
  end

  def test_it_can_return_instance_of_invoice_items
    assert_instance_of InvoiceItemRepository, se.invoice_items
  end

  def test_it_can_return_instance_of_customers
    assert_instance_of CustomerRepository, se.customers
  end

  def test_it_can_return_instance_of_transactions
    assert_instance_of TransactionRepository, se.transactions
  end
end
