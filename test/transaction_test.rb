require_relative 'test_helper'

class TransactionTest < Minitest::Test
  attr_reader :transaction

  def setup
    @transaction = Transaction.new('./test/fixtures/transactions_truncated.csv', $sales_engine)
  end

  def test_its_a_transaction
    assert_instance_of Transaction, transaction
  end

  def test_it_knows_its_own_info
    assert_equal 2650, transaction.id
    assert_equal 1, transaction.invoice_id
    assert_equal 4306389908591848, transaction.credit_card_number
    assert_equal '0914', transaction.credit_card_expiration_date
    assert_equal 'success', transaction.result
    assert_equal Time.parse('2012-02-26 20:58:23 UTC'), transaction.created_at
    assert_equal Time.parse('2012-02-26 20:58:23 UTC'),transaction.updated_at
  end

  def test_it_knows_its_invoice
    assert_instance_of Invoice, transaction.invoice
    assert_equal transaction.invoice_id, transaction.invoice.id
  end
end
