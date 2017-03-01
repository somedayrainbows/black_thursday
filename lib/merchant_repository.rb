require_relative 'merchant'

class MerchantRepository

  attr_accessor :collection, :child

  def initialize(path, sales_engine)
    @collection = Hash.new
    @child = Merchant
    populate_repository(path, sales_engine)
  end

  include RepositoryMethods
  extend ClassMethods

  def inspect
    "#<#{self.class} #{@collection.size} rows>"
  end

end
