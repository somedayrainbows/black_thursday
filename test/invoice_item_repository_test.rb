require 'minitest/autorun'
require 'minitest/pride'
require_relative './../lib/sales_engine'
require_relative './../lib/invoice_item_repository'
require 'csv'

class InvoiceItemRepositoryTest < Minitest::Test
  attr_reader :se, :invoice_item_repository

  def setup
    @se = SalesEngine.from_csv({:items => "./test/fixtures/items_truncated.csv", :merchants => "./test/fixtures/merchants_truncated.csv", :invoices => "./test/fixtures/invoices_truncated.csv", :invoice_items => "./test/fixtures/invoice_items_truncated.csv"})
    path = ('./test/fixtures/invoice_items_truncated.csv')
    @invoice_item_repository = InvoiceItemRepository.new(path, nil)
   end

  def test_it_exists
    assert_instance_of InvoiceItemRepository, invoice_item_repository
  end

  def test_it_returns_an_array_of_invoice_items
    assert_equal 467, se.invoice_items.all.count
    assert Array, invoice_item_repository.all
    assert_instance_of InvoiceItem, invoice_item_repository.all.sample
  end

end
