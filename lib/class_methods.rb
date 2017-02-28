module ClassMethods
  def from_csv(path, sales_engine = nil)
    new(path, sales_engine)
  end

  def read_csv(path)
    data = CSV.read(path, headers: true, header_converters: :symbol)
  end
end
