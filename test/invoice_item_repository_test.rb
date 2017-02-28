require_relative './../lib/invoice_item_repository'
require 'csv'
require_relative 'test_helper'
require 'pry'

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

  def test_it_can_find_itself_with_its_id
    assert_instance_of InvoiceItem, invoice_item_repository.find_by_id(343)

    refute nil, invoice_item_repository.find_by_id(343343243242)
  end

  def test_it_can_find_all_by_item_id
    assert_instance_of InvoiceItem, invoice_item_repository.find_all_by_item_id(263563764).sample

    refute nil, invoice_item_repository.find_by_id(343343243244)

    assert_equal 2, invoice_item_repository.find_all_by_item_id(263563764).count
  end

  def test_it_can_find_all_by_invoice_id
    assert_instance_of InvoiceItem, invoice_item_repository.find_all_by_invoice_id(14).sample

    refute nil, invoice_item_repository.find_by_id(343343243243)

    assert_equal 8, invoice_item_repository.find_all_by_invoice_id(14).count

    #- returns either [] or one or more matches which have a matching invoice ID
  end

end
