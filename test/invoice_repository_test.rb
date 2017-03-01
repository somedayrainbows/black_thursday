require_relative 'test_helper'

class InvoiceRepositoryTest < Minitest::Test

  attr_reader :invoice_repository

  def setup
    @invoice_repository = InvoiceRepository.from_csv('./test/fixtures/invoices_truncated.csv')
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, invoice_repository
  end

  def test_it_returns_all_known_invoices
    assert_equal 99, invoice_repository.all.count
    assert_instance_of Invoice, invoice_repository.all.sample
  end

  def test_it_finds_by_id
    assert_equal invoice_repository.all.first, invoice_repository.find_by_id(1)
    refute invoice_repository.find_by_id(-1)
  end

  def test_it_finds_all_by_customer_id
    assert_equal 8, invoice_repository.find_all_by_customer_id(1).count
    assert_instance_of Invoice, invoice_repository.find_all_by_customer_id(1).sample
  end

  def test_it_finds_all_by_merchant_id
    assert_equal 2, invoice_repository.find_all_by_merchant_id(12335955).count
    assert_equal [], invoice_repository.find_all_by_merchant_id(-1)
    assert_instance_of Invoice, invoice_repository.find_all_by_merchant_id(12335955).sample
  end

  def test_it_finds_all_by_status
    assert_equal 62, invoice_repository.find_all_by_status(:shipped).count
    assert_equal 8, invoice_repository.find_all_by_status(:returned).count
    assert_equal 29, invoice_repository.find_all_by_status(:pending).count
    assert_instance_of Invoice, invoice_repository.find_all_by_status(:returned).sample
  end

end
