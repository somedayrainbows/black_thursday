require_relative 'repository_methods'
require_relative 'class_methods'

class TransactionRepository
  extend ClassMethods
  include RepositoryMethods
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
