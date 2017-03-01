require_relative './merchant_repository'
require_relative './item_repository'
require_relative './invoice_repository'
require_relative './invoice_item_repository'
require_relative './customer_repository'
require_relative './transaction_repository'

class SalesEngine

  extend ClassMethods

  attr_reader :merchants, :items, :invoices, :invoice_items, :customers, :transactions
# Refactor: Create repositories with a "build params hash" method that extracts headers and vals from CSV row
  def initialize(paths)
    @merchants = MerchantRepository.from_csv(paths[:merchants], self)
    @items = ItemRepository.from_csv(paths[:items], self)
    @invoices = InvoiceRepository.from_csv(paths[:invoices], self)
    @invoice_items = InvoiceItemRepository.from_csv(paths[:invoice_items], self)
    @customers = CustomerRepository.from_csv(paths[:customers], self)
    @transactions = TransactionRepository.from_csv(paths[:transactions], self)
  end

  def self.from_csv(path)
    new(path)
  end

end
