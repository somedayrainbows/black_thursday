require 'minitest/autorun'
require 'minitest/emoji'
require_relative './../lib/transaction_repository'
require_relative './../lib/sales_engine'

class TransactionRepositoryTest < Minitest::Spec

  attr_reader :se

  def setup
    @se = SalesEngine.from_csv({
                                 :items     => "./test/fixtures/items_truncated.csv",
                                 :merchants => "./test/fixtures/merchants_truncated.csv",
                                 :invoices => "./test/fixtures/invoices_truncated.csv",
                                 :transactions => "./test/fixtures/transactions_truncated.csv" # switch to truncated after building find_all_by_invoice_id
    })
    @tr = TransactionRepository.from_csv('./data/transactions.csv', nil)
  end

  def test_it_can_find_a_transaction_from_a_transaction_id
  end

  def test_it_can_find_all_by_invoice_id
  end


end
