module ClassMethods
  def from_csv(path, sales_engine = nil)
    new(path, sales_engine)
  end
end
