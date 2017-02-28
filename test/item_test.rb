require_relative 'test_helper'
require_relative './../lib/item'

class ItemTest < Minitest::Test

  attr_reader :se

  def setup
    @se = $sales_engine
  end

  def test_it_returns_its_merchant
    merchant = se.merchants.all.first
    item = merchant.items.first
    assert_equal merchant, item.merchant
  end

end
