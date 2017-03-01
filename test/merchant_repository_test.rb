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

  def test_it_returns_all_known_merchant_instances
    assert_equal 227, merchant_repository.all.length
  end

  def test_it_finds_an_merchant_by_id
    assert_instance_of Merchant, merchant_repository.find_by_id(263396209)
  end

  def test_it_finds_an_merchant_by_name
    assert_instance_of Merchant, merchant_repository.find_by_name("Vogue Paris Original Givenchy 2307")

    refute nil, merchant_repository.find_by_name("vogue")
  end

  def test_it_finds_an_merchant_with_description_fragment
    assert_equal [], merchant_repository.find_all_with_description("fast cars")

    assert_instance_of Merchant, merchant_repository.find_all_with_description("wizard").sample
  end

  def test_it_finds_all_merchants_by_supplied_price
    assert_equal 12, merchant_repository.find_all_by_price(20).count

    assert_instance_of Merchant, merchant_repository.find_all_by_price(20).sample
  end

  def test_it_finds_all_merchants_in_a_supplied_range
    assert_equal 58, merchant_repository.find_all_by_price_in_range(15..25).count

    assert_instance_of Merchant, merchant_repository.find_all_by_price_in_range(50..100).sample
  end

  def test_it_finds_all_merchants_by_merchant_id
    assert_equal 3, merchant_repository.find_all_by_merchant_id(12334105).count

    assert_instance_of Merchant, merchant_repository.find_all_by_merchant_id(12334105).sample
  end

end
