require_relative 'test_helper'
require_relative './../lib/transaction_repository'


class TransactionRepositoryTest < Minitest::Test

  attr_reader :se, :transaction_repository

  def setup
    @se = $sales_engine
    @transaction_repository = TransactionRepository.from_csv('./test/fixtures/transactions_truncated.csv')
  end

  def test_it_can_find_a_transaction_from_a_transaction_id
    transaction = transaction_repository.all.first
    assert_equal transaction_repository.find_by_id(2650), transaction
  end

  def test_it_can_find_all_by_invoice_id
    transactions = transaction_repository.find_all_by_invoice_id(2179)
    assert_equal 2, transactions.count
    assert_instance_of Transaction, transactions.sample
  end

  def test_it_can_find_all_by_invoice_id
  end
end

