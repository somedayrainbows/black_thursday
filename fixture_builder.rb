require 'CSV'
require_relative './lib/sales_engine'

se = SalesEngine.from_csv({:items => "./data/items.csv",
  :merchants => "./data/merchants.csv",
  :invoices => "./data/invoices.csv",
  :invoice_items => "./data/invoice_items.csv",
  :transactions => "./data/transactions.csv"})

se.transactions
