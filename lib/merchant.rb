class Merchant

  extend ClassMethods

  attr_reader :name,
              :id,
              :created_at,
              :updated_at,
              :se

  def initialize(params, sales_engine)
    params = Merchant.read_csv(params).first if params.instance_of?(String)
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

  def customers
    common_invoices = se.invoices.find_all_by_merchant_id(id)
    customer_ids = common_invoices.reduce([]) do |uniq_customer_ids, invoice|
      id_present = uniq_customer_ids.include?(invoice.customer_id)
      uniq_customer_ids << invoice.customer_id unless id_present
      uniq_customer_ids
    end
    customer_ids.map do |customer_id|
      se.customers.find_by_id(customer_id)
    end
  end
end

