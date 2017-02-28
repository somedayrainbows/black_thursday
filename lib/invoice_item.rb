require_relative 'class_methods'
require 'date'
require 'bigdecimal'
require 'pry'

class InvoiceItem

  extend ClassMethods

  attr_reader :id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at, :se

  def initialize(params, sales_engine)
    @se = sales_engine
    @id = params[:id].to_i
    @item_id = params[:item_id].to_i
    @invoice_id = params[:invoice_id].to_i
    @quantity = params[:quantity].to_i
    @unit_price = params[:unit_price].to_i
    @created_at = Time.parse(params[:created_at])
    @updated_at = Time.parse(params[:updated_at])
  end

  def unit_price_to_dollars
    BigDecimal.new(unit_price) / 100
  end

end
