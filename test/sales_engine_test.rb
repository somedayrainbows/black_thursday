require_relative 'test_helper'

class SalesEngineTest < Minitest::Test
  attr_reader :se, :merchant_repository, :item_repository, :invoice_repository, :invoice_item_repository, :customer_repository, :transaction_repository

  def setup
    @se = $sales_engine
  end

  def test_it_can_return_instance_of_merchants
    assert_instance_of MerchantRepository, se.merchant_repository
  end


end
