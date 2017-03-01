require_relative 'test_helper'

class ItemTest < Minitest::Test

  attr_reader :item

  def setup
    @item = Item.new('./test/fixtures/items_truncated.csv', $sales_engine)
  end

  def test_it_returns_its_merchant
    assert_instance_of Merchant, item.merchant
    assert_equal item.merchant_id, item.merchant.id
  end
end