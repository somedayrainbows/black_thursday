require_relative 'test_helper'

class ItemRepositoryTest < Minitest::Test
  attr_reader :se, :item_repository

  def setup
    @se = $sales_engine
    @item_repository = ItemRepository.from_csv('./test/fixtures/items_truncated.csv')
  end

  def test_it_exists
    assert_instance_of ItemRepository, item_repository
  end

  def test_it_returns_all_known_item_instances
    assert_equal 227, item_repository.all.length
  end

  def test_it_finds_an_item_by_id
    assert_instance_of Item, item_repository.find_by_id(263396209)
  end

  def test_it_finds_an_item_by_name
    assert_instance_of Item, item_repository.find_by_name("Vogue Paris Original Givenchy 2307")

    refute nil, item_repository.find_by_name("vogue")
  end

  def test_it_finds_an_item_with_description_fragment
    assert_equal [], item_repository.find_all_with_description("fast cars")

    assert_instance_of Item, item_repository.find_all_with_description("wizard").sample
  end

  def test_it_finds_all_items_by_supplied_price
    assert_equal 12, item_repository.find_all_by_price(20).count

    assert_instance_of Item, item_repository.find_all_by_price(20).sample
  end

  def test_it_finds_all_items_in_a_supplied_range
    assert_equal 58, item_repository.find_all_by_price_in_range(15..25).count

    assert_instance_of Item, item_repository.find_all_by_price_in_range(50..100).sample
  end

  def test_it_finds_all_items_by_merchant_id
    assert_equal 3, item_repository.find_all_by_merchant_id(12334105).count

    assert_instance_of Item, item_repository.find_all_by_merchant_id(12334105).sample
  end

end
