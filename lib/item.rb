class Item

  extend ClassMethods

  attr_reader :name, :id, :description, :unit_price, :created_at, :updated_at, :merchant_id, :se

  def initialize(params, sales_engine)
    params = Item.read_csv(params).first if params.instance_of?(String)

    @se = sales_engine
    @id = params[:id].to_i
    @name = params[:name]
    @description = params[:description]
    @unit_price = unit_price_to_dollars(params[:unit_price])
    @created_at = Time.parse(params[:created_at])
    @updated_at = Time.parse(params[:updated_at])
    @merchant_id = params[:merchant_id].to_i # test coverage for this
  end

  def unit_price_to_dollars(price)
    BigDecimal.new(price) / 100
  end

  def merchant
    se.merchants.find_by_id(merchant_id)
  end
end
