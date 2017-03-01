require_relative 'item'

class ItemRepository

  include RepositoryMethods
  extend ClassMethods

  attr_accessor :collection, :child

  def initialize(path, sales_engine)
    @child = Item
    @collection = Hash.new
    populate_repository(path, sales_engine)
  end


  def inspect
    "#<#{self.class} #{@collection.size} rows>"
  end

end
