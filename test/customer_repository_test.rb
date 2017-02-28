require_relative './../lib/customer_repository'
require 'csv'
require_relative 'test_helper'
require 'pry'

class CustomerRepositoryTest < Minitest::Test
  attr_reader :se, :customer_repository

  def setup
    @se = $sales_engine
    @customer_repository = CustomerRepository.from_csv('./test/fixtures/customers_truncated.csv')
  end


end
