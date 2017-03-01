require_relative 'test_helper'

class ItemRepositoryTest < Minitest::Test

  attr_reader :item_repository

  def setup
    @item_repository = ItemRepository.from_csv('./test/fixtures/items_truncated.csv')
  end

  def test_it_exists
    assert_instance_of ItemRepository, item_repository
  end

  def test_it_returns_all_known_item_instances
    assert_equal 227, item_repository.all.count
  end

  def test_it_finds_an_item_by_id
    assert_equal item_repository.all.first, item_repository.find_by_id(263543344)
  end

  def test_it_finds_an_item_by_name
    vogue_item = item_repository.find_by_id(263396209)

    assert_equal vogue_item, item_repository.find_by_name("Vogue Paris Original Givenchy 2307")
    refute item_repository.find_by_name("NOTANAME")
  end

  def test_it_finds_an_item_with_description_fragment
    wizard_items = item_repository.find_all_with_description("wizard")

    assert_equal 3, wizard_items.count
    assert_instance_of Item, wizard_items.sample
    assert_empty item_repository.find_all_with_description("BADDESCRIPTION")
  end

  def test_it_finds_all_items_by_supplied_price
    items = item_repository.find_all_by_price(20)
    item = items.sample

    assert_equal 12, items.count
    assert_instance_of Item, item
    assert_equal 20, item.unit_price
  end

  def test_it_finds_all_items_in_a_supplied_range
    items_in_range = item_repository.find_all_by_price_in_range(50..60)
    item = items_in_range.sample
    price = item.unit_price

    assert_equal 12, items_in_range.count
    assert_instance_of Item, item
    assert price >= 50 && price <= 60
  end

  def test_it_finds_all_items_by_merchant_id
    items = item_repository.find_all_by_merchant_id(12334105)
    item = items.sample

    assert_equal 3, items.count
    assert_instance_of Item, item
  end
end
