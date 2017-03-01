require_relative 'test_helper'

class MerchantRepositoryTest < Minitest::Test
  attr_reader :se, :merchant_repository

  def setup
    @se = $sales_engine
    @merchant_repository = MerchantRepository.from_csv('./test/fixtures/merchants_truncated.csv')
  end

  def test_it_exists
    assert_instance_of MerchantRepository, merchant_repository
  end

  def test_it_returns_all_known_merchants
    assert_equal 89, merchant_repository.all.count
  end

  def test_it_finds_an_merchant_by_id
    assert_instance_of Merchant, merchant_repository.find_by_id(12334861)

    refute nil, merchant_repository.find_by_id(9823722)
  end

  def test_it_finds_an_merchant_by_name
    assert_instance_of Merchant, merchant_repository.find_by_name("SamsMagicShop")

    refute nil, merchant_repository.find_by_name("magic")
  end

  def test_it_finds_all_merchants_by_name
    assert_equal 3, merchant_repository.find_all_by_name("the").count

    assert_instance_of Merchant, merchant_repository.find_all_by_name("sam").sample
  end
end
