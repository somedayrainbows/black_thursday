require_relative 'test_helper'

class InvoiceRepositoryTest < Minitest::Test

  attr_reader :se, :invoice_repository

  def setup
    @se = $sales_engine
    @invoice_repository = InvoiceRepository.from_csv('./test/fixtures/invoices_truncated.csv')
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, invoice_repository
  end

  def test_it_returns_all_known_invoices
    assert_equal 99, invoice_repository.all.count
  end

  def test_it_finds_by_id
    invoice = invoice_repository.all.first

    assert_equal invoice, invoice_repository.find_by_id(1)
    assert_nil invoice_repository.find_by_id(-1)
  end

  def test_it_finds_all_by_customer_id
    assert_equal 8, invoice_repository.find_all_by_customer_id(1).count
    assert_instance_of Invoice, invoice_repository.find_all_by_customer_id(1).first
  end

  def test_it_finds_all_by_merchant_id
    assert_equal 2, invoice_repository.find_all_by_merchant_id(12335955).count
    assert_equal [], invoice_repository.find_all_by_merchant_id(-1)
    assert_instance_of Invoice, invoice_repository.find_all_by_merchant_id(12335955).first
    #returns either [] or one or more matches which have a matching merchant ID
  end

  def test_it_finds_all_by_status
    assert_equal 62, invoice_repository.find_all_by_status(:shipped).count
    assert_equal 8, invoice_repository.find_all_by_status(:returned).count
    assert_equal 29, invoice_repository.find_all_by_status(:pending).count
    assert_instance_of Invoice, invoice_repository.find_all_by_status(:returned).first

    # returns either [] or one or more matches which have a matching status
  end

end
