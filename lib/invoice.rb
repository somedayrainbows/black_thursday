class Invoice

  extend ClassMethods

  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :se

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

  def invoice_items
    se.invoice_items.find_all_by_invoice_id(id)
  end

  def items
    item_ids = []
    se.invoice_items.all.map do |invoice_item|
      item_ids << invoice_item.item_id if invoice_item.invoice_id == id
    end
    item_objects = item_ids.map do |item_id|
      se.items.find_by_id(item_id)
    end
  end

  def is_paid_in_full?
    transactions = se.transactions.find_all_by_invoice_id(id)
    return false if transactions.empty?
    transactions.any? do |transaction|
      transaction.result == 'success'
    end
  end

  def total
    invoice_items = se.invoice_items.find_all_by_invoice_id(id)
    invoice_items.reduce(0) do |total, invoice_item|
      total += invoice_item.unit_price * invoice_item.quantity
    end
  end

  def transactions
    se.transactions.all.reduce([]) do |transaction_objects, transaction|
      transaction_objects << transaction if transaction.invoice_id == id
      transaction_objects
    end
  end

  def customer
    se.customers.find_by_id(customer_id)
  end
end
