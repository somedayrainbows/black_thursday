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
    # returns either nil or an instance of Item with a matching ID
  end

  def test_it_finds_an_item_by_name
    # assert_ item_repository.find_by_name("Vogue Paris Original Givenchy 2307")
    # returns either nil or an instance of Item having done a case insensitive search
  end

  def test_it_finds_an_item_with_description_fragment
    skip
    assert_equal [], item_repository.find_all_with_description("fast cars")
    # returns either [] or instances of Item where the supplied string appears in the item description (case insensitive)
  end

  def test_it_finds_all_items_by_supplied_price
    skip
    assert_equal [], item_repository.find_all_by_price(14)
    # returns either [] or instances of Item where the supplied price exactly matches
  end

  def test_it_finds_all_items_in_a_supplied_range
    assert_equal [], item_repository.find_all_by_price_in_range(range)
    # returns either [] or instances of Item where the supplied price is in the supplied range (a single Ruby range instance is passed in)
  end

  def test_it_finds_all_items_by_merchant_id
    skip
    assert_equal [], item_repository.find_all_by_merchant_id(12334105)
    # returns either [] or instances of Item where the supplied merchant ID matches that supplied
  end

end
