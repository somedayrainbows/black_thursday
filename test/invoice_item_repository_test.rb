require_relative './../lib/invoice_item_repository'
require 'csv'
require_relative 'test_helper'

class InvoiceItemRepositoryTest < Minitest::Test
  attr_reader :se, :invoice_item_repository

  def setup
    @se = $sales_engine
    @invoice_item_repository = InvoiceItemRepository.from_csv('./test/fixtures/invoice_items_truncated.csv')
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
