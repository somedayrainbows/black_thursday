require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/emoji'
require_relative './../lib/sales_engine'

$sales_engine = SalesEngine.from_csv({:items => "./test/fixtures/items_truncated.csv",
  :merchants => "./test/fixtures/merchants_truncated.csv",
  :invoices => "./test/fixtures/invoices_truncated.csv",
  :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
  :transactions => "./test/fixtures/transactions_truncated.csv"})