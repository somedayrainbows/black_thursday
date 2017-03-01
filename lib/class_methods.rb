module ClassMethods
  def from_csv(path, sales_engine = nil)
    new(read_csv(path), sales_engine)
  end

  def read_csv(path)
    to_return = CSV.read(path, headers: true, header_converters: :symbol)
    to_return
  end
end