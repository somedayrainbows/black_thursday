class Merchant

  attr_reader :name, :id, :se

  def initialize(params, sales_engine)
    @name = params[:name]
    @id = params[:id].to_i
    @se = sales_engine
  end

  def items
    se.items.find_all_by_merchant_id(id)
  end

  def invoices
    se.invoices.find_all_by_merchant_id(id)
  end
end