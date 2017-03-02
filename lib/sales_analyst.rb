class SalesAnalyst
  attr_reader :se, :avg_items_per_merchant, :avg_items_per_merchant_standard_deviation

  def initialize(sales_engine)
    @se = sales_engine
    @avg_items_per_merchant = average_items_per_merchant
    @avg_items_per_merchant_standard_deviation = average_items_per_merchant_standard_deviation
  end

  # Refactor simple count references
  def average_items_per_merchant
    (se.items.all.count.to_f / se.merchants.all.count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    items_per_merchant = se.merchants.all.map do |merchant|
      merchant.items.count
    end
    find_standard_deviation(items_per_merchant)
  end

  def find_standard_deviation(set)
    average = find_average(set)
    squared_diffs = set.reduce(0) do |memo, entry|
      memo += ((entry - average) ** 2)
    end
    std_dev = Math.sqrt(squared_diffs.to_f / (set.count - 1)).round(2)
  end

  def merchants_with_high_item_count
    se.merchants.all.select do |merchant|
      merchant.items.count > avg_items_per_merchant + avg_items_per_merchant_standard_deviation
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = se.merchants.find_by_id(merchant_id)
    total = merchant.items.reduce(0) do |sum, item|
      sum += item.unit_price
    end
    (total / merchant.items.count).round(2)
  end

  def average_average_price_per_merchant
    total = se.merchants.all.reduce(0) do |sum, merchant|
      sum += average_item_price_for_merchant(merchant.id)
    end
    (total / se.merchants.all.count).round(2)
  end

  def golden_items
    #refactor to abstract creating the average
    all_items_unit_price = se.items.all.map do |item|
      item.unit_price
    end
    std_dev = find_standard_deviation(all_items_unit_price)

    se.items.all.select do |item|
      item.unit_price > (std_dev * 2) + find_average(all_items_unit_price)
    end
  end

  def average_invoices_per_merchant
    s = se.merchants.all.map do |merchant|
      merchant.invoices.count
    end
    find_average(s)
  end

  def average_invoices_per_merchant_standard_deviation
    invoices_per_merchant = se.merchants.all.reduce([]) do |memo, merchant|
      memo << merchant.invoices.count
    end
    find_standard_deviation(invoices_per_merchant)
  end

  def find_average(set)
    (set.reduce(:+) / set.count.to_f).round(2)
  end

  def top_merchants_by_invoice_count
    set = se.merchants.all.map do |merchant|
      merchant.invoices.count
    end
    whale_threshold = find_average(set) + (find_standard_deviation(set) * 2)
    se.merchants.all.select do |merchant|
      merchant.invoices.count > whale_threshold
    end
  end

  def bottom_merchants_by_invoice_count
    set = se.merchants.all.map do |merchant|
      merchant.invoices.count
    end
    guppy_threshold = find_average(set) - (find_standard_deviation(set) * 2)
    se.merchants.all.select do |merchant|
      merchant.invoices.count < guppy_threshold
    end
  end

  def find_day(entry)
    entry.created_at.strftime('%A')
  end

  def find_entries_for_each_day(set)
    set.reduce(Hash.new(0)) do | day_hash, entry|
      day = find_day(entry)
      day_hash[day] += 1
      day_hash
    end
  end

  def calculate_total_daily_entries(set)
    set.reduce([]) do |memo, (day, count)|
      memo << count
      memo
    end

  end

  def top_days_by_invoice_count
    day_counts = calculate_total_daily_entries(find_entries_for_each_day(se.invoices.all))
    days_threshold = find_average(day_counts) + find_standard_deviation(day_counts)
    find_entries_for_each_day(se.invoices.all).reduce([]) do |top_days, (day, count)|
      top_days << day if count > days_threshold
      top_days
    end
  end

  def invoice_status(status)
    statuses = se.invoices.all.reduce(Hash.new(0)) do | status_hash, entry|
      status_hash[entry.status] += 1
      status_hash
    end
    ((statuses[status] / se.invoices.all.count.to_f) * 100).round(2)
  end

  def top_merchant_for_customer(customer_id)
    customer = se.customers.find_by_id(customer_id)
    invoices = se.invoices.all.select do |invoice|
      invoice.customer_id == customer_id
    end
    invoice_items = invoices.collect do |invoice|
      se.invoice_items.find_all_by_invoice_id(invoice.id)
    end.flatten
    grouped = invoice_items.group_by do |ii|
      se.invoices.find_by_id(ii.invoice_id).merchant_id
    end
    number_of_purchases_at_merchant = grouped.reduce(Hash.new(0)) do |hash, (merchant_id, invoice_items)|
      hash[merchant_id] = invoice_items.reduce(0) do |total, invoice_item|
        total += invoice_item.quantity
      end
      hash
    end
    favorite_merchant_id = number_of_purchases_at_merchant.max_by do |merchant_id, purchases_count|
      purchases_count
    end.first
    se.merchants.find_by_id(favorite_merchant_id)
  end

  def one_time_buyers
    se.customers.all.select do |customer|
      customer.fully_paid_invoices.count == 1
    end
  end
end
