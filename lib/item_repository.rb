require_relative 'item'

class ItemRepository
  attr_accessor :collection, :child

  def initialize(path, sales_engine)
    @child = Item
    @collection = Hash.new
    populate_repository(path, sales_engine)
  end

  include RepositoryMethods
  extend ClassMethods

  def inspect
    "#<#{self.class} #{@collection.size} rows>"
  end

end
