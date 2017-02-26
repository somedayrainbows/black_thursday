require 'minitest/autorun'
require 'minitest/emoji'
require 'mocha/mini_test'
require 'minitest/unit'
require_relative './../lib/sales_engine'

class MerchantTest < Minitest::Test

  attr_reader :se

  def setup
    @se = SalesEngine.from_csv({
                                 :items     => "./test/fixtures/items_truncated.csv",
                                 :merchants => "./test/fixtures/merchants_truncated.csv",
                                 :invoices => "./test/fixtures/invoices_truncated.csv"
    })
  end

  def test_it_exists
    assert se
  end

  def test_items_returns_merchants_items
    assert_equal 3, se.merchants.all.first.items.length
  end

  def test_it_can_find_its_invoices
    merchant = se.merchants.find_by_id(12335938)
    assert_equal 1, merchant.invoices.count

  end
end
