require_relative 'merchant'

class MerchantRepository

  include RepositoryMethods
  extend ClassMethods

  attr_accessor :collection,
                :child

  def initialize(path, sales_engine)
    @collection = Hash.new
    @child = Merchant
    populate_repository(path, sales_engine)
  end


  def inspect
    "#<#{self.class} #{@collection.size} rows>"
  end

end
