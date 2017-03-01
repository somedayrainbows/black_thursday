require_relative 'test_helper'
require_relative './../lib/transaction'

class TransactionTest < Minitest::Test

  attr_reader :se, :transaction

  def setup
    @se = $sales_engine
    @transaction = Transaction.new('./test/fixtures/transactions_truncated.csv', nil)
  end

  def test_its_a_transaction
    assert_instance_of Transaction, transaction
  end

  def test_it_knows_its_own_info
    assert_equal 1, transaction.id
    assert_equal 2179, transaction.invoice_id
    assert_equal 4068631943231473, transaction.credit_card_number
    assert_equal Date.parse('0217'), transaction.credit_card_expiration_date
    assert_equal 'success', transaction.result
    assert_equal Time.parse('2012-02-26 20:56:56 UTC'), transaction.created_at
    assert_equal Time.parse('2012-02-26 20:56:56 UTC'),transaction.updated_at
  end
end
