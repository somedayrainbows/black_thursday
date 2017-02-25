require_relative './invoice'
require_relative './repository_methods'
require 'pry'

class InvoiceRepository
  attr_accessor :collection, :child

  def initialize(path, sales_engine)
    @child = Invoice
    @collection = Hash.new
    populate_repository(path, sales_engine)

  end

  include RepositoryMethods


end