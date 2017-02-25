require 'minitest/autorun'
require 'minitest/emoji'
require 'mocha/mini_test'
require 'minitest/unit'
require_relative './../lib/sales_engine'

class MerchantTest < Minitest::Test

  attr_reader :se

  def setup
    @se = SalesEngine.from_csv({
                                 :items     => "./data/items.csv",
                                 :merchants => "./data/merchants.csv",
    })
  end

  def test_it_exists
    assert se
  end

  def test_it_knows_its_items
    skip
    item1 = mock("item")
    item2 = mock("Item")
    se.add_items([item1, item2])
    assert_include
  end

  def test_items_returns_merchants_items
    assert_equal 3, se.merchants.all.first.items.length
  end

  def test_
  end
end
