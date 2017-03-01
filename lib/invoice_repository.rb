require_relative 'invoice'

class InvoiceRepository
  attr_accessor :collection, :child

  def initialize(path, sales_engine)
    @child = Invoice
    @collection = Hash.new
    populate_repository(path, sales_engine)
  end

  include RepositoryMethods
  extend ClassMethods

  def inspect
    "#<#{self.class} #{@collection.size} rows>"
  end

end
