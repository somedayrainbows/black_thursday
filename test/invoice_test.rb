require 'minitest/autorun'
require 'minitest/pride'
require_relative './../lib/invoice'
require_relative './../lib/sales_engine'
require 'csv'


class InvoiceTest < Minitest::Test
  attr_reader :invoice

  def setup
    path = CSV.read('./test/fixtures/invoices_truncated.csv', headers: true, header_converters: :symbol).first
    @invoice = Invoice.new(path, nil)
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
    assert_equal "pending", invoice.status
    assert_equal Date.new(2009, 02, 07), invoice.created_at
    assert_equal Date.new(2014, 03, 15), invoice.updated_at
  end

end
