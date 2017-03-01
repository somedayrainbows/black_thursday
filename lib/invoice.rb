class Invoice

  extend ClassMethods

  attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at, :se

  def initialize(params, sales_engine)
    params = Invoice.read_csv(params).first if params.instance_of?(String)
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

  def items
    item_ids = []
    se.invoice_items.all.map do |invoice_item|
      item_ids << invoice_item.item_id if invoice_item.invoice_id == id
    end
    item_ids
    se.items.all.reduce([]) do |item_objects, item|
    item_objects << item if item_ids.include?(item.id)
      item_objects
    end
  end

end
