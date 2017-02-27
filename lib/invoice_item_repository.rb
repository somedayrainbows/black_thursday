require_relative './invoice_item'
require_relative './repository_methods'
require 'pry'

class InvoiceItemRepository
  attr_accessor :collection, :child

  def initialize(path, sales_engine)
    @child = InvoiceItem
    @collection = Hash.new
    populate_repository(path, sales_engine)
  end

  include RepositoryMethods

  def inspect
    "#<#{self.class} #{@collection.size} rows>"
  end

end
