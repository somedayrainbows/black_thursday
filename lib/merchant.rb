class Merchant

  attr_reader :name, :id, :se

  def initialize(params, sales_engine)
    @se = sales_engine
    @name = params[:name]
    @id = params[:id].to_i
    @created_at = Date.strptime(params[:created_at])
    @updated_at = Date.strptime(params[:updated_at])
  end

  def items
    se.items.find_all_by_merchant_id(id)
  end

  def invoices
    se.invoices.find_all_by_merchant_id(id)
  end
end
