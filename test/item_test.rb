require 'minitest/autorun'
require 'minitest/pride'
require_relative './../lib/item'
require_relative './../lib/sales_engine'

class ItemTest < Minitest::Test

  attr_reader :se

  def setup
    @se = SalesEngine.from_csv({
                                 :items     => "./data/items.csv",
                                 :merchants => "./data/merchants.csv",
    })
  end

  def test_it_returns_its_merchant
    merchant = se.merchants.all.first
    item = merchant.items.first
    assert_equal merchant, item.merchant
  end

end