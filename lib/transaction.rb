class Transaction

  extend ClassMethods

  attr_reader :se,
              :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at

  def initialize(params, sales_engine)
    params = Transaction.read_csv(params).first if params.instance_of?(String)
    @se = sales_engine
    @id = params[:id].to_i
    @invoice_id = params[:invoice_id].to_i
    @credit_card_number = params[:credit_card_number].to_i
    expiration_date = params[:credit_card_expiration_date].rjust(4,'0')
    @credit_card_expiration_date = expiration_date
    @result = params[:result]
    @created_at = Time.parse(params[:created_at])
    @updated_at = Time.parse(params[:updated_at])
  end

  def invoice
    se.invoices.find_by_id(invoice_id)
  end
end
