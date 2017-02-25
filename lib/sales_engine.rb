require_relative './merchant_repository'
require_relative './item_repository'
require_relative './invoice_repository'


class SalesEngine

  attr_reader :merchants, :items, :invoices

  def initialize(paths)
    @merchants = MerchantRepository.new(paths[:merchants], self)
    @items = ItemRepository.new(paths[:items], self)
    @invoices = InvoiceRepository.new(paths[:invoices], self)
  end

  def self.from_csv(data_paths)
    new(data_paths)
  end

end
