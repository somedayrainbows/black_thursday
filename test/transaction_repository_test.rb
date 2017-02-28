require_relative 'test_helper'
require_relative './../lib/transaction_repository'


class TransactionRepositoryTest < Minitest::Test

  attr_reader :se, :transaction_repository, :transaction

  def setup
    @se = $sales_engine
    @transaction_repository = TransactionRepository.from_csv('./data/transactions.csv')
    @transaction = transaction_repository.all.first
  end

  def test_it_can_find_a_transaction_from_a_transaction_id
    assert_equal transaction_repository.find_by_id(1), transaction
  end

  def test_it_can_find_all_by_invoice_id

  end

end
