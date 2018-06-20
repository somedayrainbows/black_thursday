require_relative 'test_helper'

class CustomerRepositoryTest < Minitest::Test
  attr_reader :customer_repository

  def setup
    @customer_repository = CustomerRepository.from_csv('./test/fixtures/customers_truncated.csv')
  end

  def test_it_can_return_all_customers
    assert_equal 21, customer_repository.all.count
  end

  def test_it_can_find_a_customer_by_id
    assert_instance_of Customer, customer_repository.find_by_id(17)
  end

  def test_it_can_find_all_by_first_name
    assert_instance_of Customer, customer_repository.find_all_by_first_name("Jo").sample

    assert_equal 2, customer_repository.find_all_by_first_name("Jo").count
  end

  def test_it_can_find_all_by_last_name
    assert_instance_of Customer, customer_repository.find_all_by_last_name("on").sample

    assert_equal 2, customer_repository.find_all_by_last_name("on").count
  end
end
