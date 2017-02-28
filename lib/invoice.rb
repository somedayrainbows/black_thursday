require_relative 'class_methods'
require 'date'

class Invoice

  extend ClassMethods

  attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at, :se

  def initialize(params, sales_engine)
    @se = sales_engine
    @id = params[:id].to_i
    @customer_id = params[:customer_id].to_i
    @merchant_id = params[:merchant_id].to_i
    @status = params[:status].to_sym
    @created_at = Time.parse(params[:created_at])
    @updated_at = Time.parse(params[:updated_at])
  end

  def merchant
    se.merchants.find_by_id(merchant_id)
  end
end
