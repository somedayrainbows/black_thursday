class InvoiceItem

  extend ClassMethods

  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at,
              :se

  def initialize(params, sales_engine)
    params = InvoiceItem.read_csv(params).first if params.instance_of?(String)
    @se = sales_engine
    @id = params[:id].to_i
    @item_id = params[:item_id].to_i
    @invoice_id = params[:invoice_id].to_i
    @quantity = params[:quantity].to_i
    @unit_price = unit_price_to_dollars(params[:unit_price].to_i)
    @created_at = Time.parse(params[:created_at])
    @updated_at = Time.parse(params[:updated_at])
  end

  def unit_price_to_dollars(price)
    BigDecimal.new(price) / 100
  end


end
