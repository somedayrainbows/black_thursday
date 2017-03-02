require_relative 'test_helper'

class CustomerTest < Minitest::Test
  attr_reader :customer

  def setup
    @customer = Customer.new('./test/fixtures/customers_truncated.csv', $sales_engine)
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

  def test_it_knows_its_merchants
    assert_equal 8, customer.merchants.size
    assert_instance_of Merchant, customer.merchants.sample
  end

  def test_it_knows_its_fully_paid_invoices
    fully_paid_invoices = customer.fully_paid_invoices

    assert_equal 6, fully_paid_invoices.count
    assert_instance_of Invoice, fully_paid_invoices.sample
  end
end
