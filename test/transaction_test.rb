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
    assert_equal 2650, transaction.id
    assert_equal 1, transaction.invoice_id
    assert_equal 4306389908591848, transaction.credit_card_number
    assert_equal Date.parse('0914'), transaction.credit_card_expiration_date
    assert_equal 'success', transaction.result
    assert_equal Time.parse('2012-02-26 20:58:23 UTC'), transaction.created_at
    assert_equal Time.parse('2012-02-26 20:58:23 UTC'),transaction.updated_at
  end

  def test_it_knows_its_invoices
    invoices = transaction.invoices
    assert_equal 7, invoices.count
    assert_instance_of Invoice, invoices.sample
    assert_equal 111, invoices.sample.transaction_id
  end
end
