require_relative 'transaction'

class TransactionRepository

  include RepositoryMethods
  extend ClassMethods

  attr_accessor :collection, :child
  def initialize(path, sales_engine)
    @child = Transaction
    @collection = Hash.new
    populate_repository(path, sales_engine)
  end

  def inspect
    "#<#{self.class} #{@collection.size} rows>"
  end

end
