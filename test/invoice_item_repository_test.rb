require_relative 'test_helper'
require_relative './../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test
  attr_reader :invoice_item_repository

  def setup
    @invoice_item_repository = InvoiceItemRepository.from_csv('./test/fixtures/invoice_items_truncated.csv')
  end

  def test_it_exists
    assert_instance_of InvoiceItemRepository, invoice_item_repository
  end

  def test_it_returns_an_array_of_invoice_items
    assert_equal 467, invoice_item_repository .all.count
    assert_instance_of InvoiceItem, invoice_item_repository.all.sample
  end

  def test_it_can_find_an_item_with_id
    assert_instance_of InvoiceItem, invoice_item_repository.find_by_id(343)
  end

  def test_it_can_find_all_by_item_id
    assert_equal 2, invoice_item_repository.find_all_by_item_id(263563764).count
    assert_instance_of InvoiceItem, invoice_item_repository.find_all_by_item_id(263563764).sample
  end

  def test_it_can_find_all_by_invoice_id
    assert_equal 8, invoice_item_repository.find_all_by_invoice_id(14).count
    assert_instance_of InvoiceItem, invoice_item_repository.find_all_by_invoice_id(14).sample
  end

end
