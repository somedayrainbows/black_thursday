require_relative 'test_helper'

class MerchantTest < Minitest::Test

  attr_reader :merchant

  def setup
      @merchant = Merchant.new('./test/fixtures/merchants_truncated.csv', $sales_engine)
  end

  def test_it_exists
    assert_instance_of Merchant, merchant
  end

  def test_it_has_an_id
    assert_equal 12334365, merchant.id
  end

  def test_it_has_a_name
    assert_equal "2MAKERSMARKET", merchant.name
  end

  def test_it_knows_its_customers
    assert_equal 1, merchant.customers.count
    assert_instance_of Customer, merchant.customers.sample
  end
end
