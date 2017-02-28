require_relative 'test_helper'
require_relative './../lib/transaction_repository'


class TransactionRepositoryTest < Minitest::Test

  attr_reader :se

  def setup
    @se = $sales_engine
    @tr = TransactionRepository.from_csv('./data/transactions.csv')
  end

  def test_it_can_find_a_transaction_from_a_transaction_id

  end

  def test_it_can_find_all_by_invoice_id

  end

end
