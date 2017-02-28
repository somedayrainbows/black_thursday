require_relative 'test_helper'
require_relative './../lib/customer'

class CustomerTest < Minitest::Test

  attr_reader :se, :customer

  def setup
    @customer = Customer.new('./test/fixtures/customers_truncated.csv', nil)
  end

  def test_it_exists
    assert_instance_of Customer, customer
  end

  def test_it_has_an_id
    assert_equal 1, customer.id
  end

  def test_it_has_a_first_name
    assert_equal "Joey", customer.first_name
  end

  def test_it_has_a_last_name
    assert_equal "Ondricka", customer.last_name
  end

  def test_it_has_a_creation_date
    assert_equal Time.parse("2012-03-27 14:54:09 UTC"), customer.created_at
  end

  def test_it_has_an_updated_date
    assert_equal Time.parse("2012-03-27 14:54:09 UTC"), customer.created_at
  end

end
