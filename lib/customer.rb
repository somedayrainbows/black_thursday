require_relative 'class_methods'
require 'time'

class Customer

  extend ClassMethods

  attr_reader :id, :first_name, :last_name, :created_at, :updated_at, :se

  def initialize(params, sales_engine)
    params = Customer.read_csv(params).first if params.instance_of?(String)
    @se = sales_engine
    @id = params[:id].to_i
    @first_name = params[:first_name]
    @last_name = params[:last_name]
    @created_at = Time.parse(params[:created_at])
    @updated_at = Time.parse(params[:updated_at])
  end

end
