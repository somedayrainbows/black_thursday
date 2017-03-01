require_relative 'dependencies'

class SalesEngine

  extend ClassMethods

  attr_reader :merchants, :items, :invoices, :invoice_items, :customers, :transactions
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
