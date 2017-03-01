require_relative 'class_methods'

class Transaction

  extend ClassMethods

  attr_reader :se, :id, :invoice_id, :credit_card_number, :credit_card_expiration_date, :result, :created_at, :updated_at

  def initialize(params, sales_engine)
    params = Transaction.read_csv(params).first if params.instance_of?(String)
    @se = sales_engine
    @id = params[:id].to_i
    @invoice_id = params[:invoice_id].to_i
    @credit_card_number = params[:credit_card_number].to_i
    date_to_parse = params[:credit_card_expiration_date].rjust(4,'0')
    @credit_card_expiration_date = Date.parse(date_to_parse)
    @result = params[:result]
    @created_at = Time.parse(params[:created_at])
    @updated_at = Time.parse(params[:updated_at])
  end
end
