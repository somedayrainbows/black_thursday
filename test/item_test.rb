require_relative 'test_helper'

class ItemTest < Minitest::Test

  attr_reader :item

  def setup
    @item = Item.new('./test/fixtures/items_truncated.csv', $sales_engine)
  end

  def test_it_knows_its_own_information
    assert_equal 263543344, item.id
    assert_includes item.name, "Citrine Stones Earrings"
    assert_includes item.description,   'Beautifully Crafted'
    assert_equal 595.0, item.unit_price
    assert_equal Time.parse('2016-01-11 18:43:15 UTC'), item.created_at
    assert_equal Time.parse('2012-10-17 03:26:07 UTC'), item.updated_at
    assert_equal 12335955, item.merchant_id
  end

  def test_it_can_convert_a_price_to_big_decimal
    assert_instance_of BigDecimal, item.unit_price_to_dollars(100)
  end

  def test_it_knows_its_merchant
    assert_instance_of Merchant, item.merchant
    assert_equal item.merchant_id, item.merchant.id
  end
end