require_relative 'test_helper'

class InvoiceItemTest < Minitest::Test
  attr_reader :invoice_item

  def setup
    @invoice_item = InvoiceItem.new('./test/fixtures/invoice_items_truncated.csv', $sales_engine)
  end

  def test_it_exists
    assert_instance_of InvoiceItem, invoice_item
  end

  def test_it_returns_the_invoiceitem_id
    assert_equal 1, invoice_item.id
  end

  def test_it_returns_the_item_id
    assert_equal 263519844, invoice_item.item_id
  end

  def test_it_returns_the_invoice_id
    assert_equal 1, invoice_item.invoice_id
  end

  def test_it_returns_the_quantity
    assert_equal 5, invoice_item.quantity
  end

  def test_it_returns_the_unit_price
    assert_equal 136.35, invoice_item.unit_price
  end

  def test_it_returns_the_date_created
    assert_equal Time.parse("2012-03-27 14:54:09 UTC"), invoice_item.created_at
  end

  def test_it_returns_the_date_updated
    assert_equal Time.parse("2012-03-27 14:54:09 UTC"), invoice_item.updated_at
  end

  def test_it_can_return_unit_price_in_dollars
    assert_instance_of BigDecimal, invoice_item.unit_price
  end
end
