require 'minitest/autorun'
require 'minitest/pride'
require_relative './../lib/invoice_item'
require_relative './../lib/sales_engine'


class InvoiceItemTest < Minitest::Test
  attr_reader :se, :invoice_item

  def setup
    @se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv", :invoice_items => "./test/fixtures/invoice_items_truncated.csv"
     })
     path = CSV.read('./test/fixtures/invoice_items_truncated.csv', headers: true, header_converters: :symbol).first
     @invoice_item = InvoiceItem.new(path, nil)
  end

  def test_it_exists
    assert_instance_of InvoiceItem, invoice_item
  end

end
