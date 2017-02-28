require_relative 'class_methods'
require_relative './customer'
require_relative './repository_methods'
require 'pry'

class CustomerRepository
  attr_accessor :collection, :child

  def initialize(path, sales_engine)
    @child = Customer
    @collection = Hash.new
    populate_repository(path, sales_engine)
  end

  include RepositoryMethods
  extend ClassMethods

  def inspect
    "#<#{self.class} #{@collection.size} rows>"
  end

end
