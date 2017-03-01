require_relative 'test_helper'
require_relative './../lib/transaction_repository'


class TransactionRepositoryTest < Minitest::Test

  attr_reader :transaction_repository

  def setup
    @transaction_repository = TransactionRepository.from_csv('./test/fixtures/transactions_truncated.csv')
  end

  def test_it_can_find_a_transaction_from_a_transaction_id
    transaction = transaction_repository.all.first
    assert_equal transaction_repository.find_by_id(2650), transaction
  end

  def test_it_can_find_all_by_invoice_id
    transactions = transaction_repository.find_all_by_invoice_id(10)
    assert_equal 3, transactions.count
    assert_instance_of Transaction, transactions.sample
    assert_equal 10, transactions.sample.invoice_id
  end

  def test_it_can_find_all_by_credit_card_number
    transactions = transaction_repository.find_all_by_credit_card_number(4618812783101067)
    assert_equal 7, transactions.count
    assert_instance_of Transaction, transactions.sample
    assert_equal 4618812783101067, transactions.sample.credit_card_number
  end

  def test_it_can_find_all_by_result
    transactions = transaction_repository.find_all_by_result('success')
    assert_equal 91, transactions.count
    assert_instance_of Transaction, transactions.sample
    assert_equal 'success', transactions.sample.result
  end
end
