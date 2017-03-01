# refactor: move the csv reading into sales engine

module RepositoryMethods
  def populate_repository(data, sales_engine)
    data.each do |row|
      collection[row[:id].to_sym] = child.new(row, sales_engine)
    end
  end

  def all
    collection.map do |id, entry|
      entry
    end
  end

  def find_by_id(id)
    collection[id.to_s.to_sym]
  end

  def find_by_name(name_to_search_for)
    collection.each do |id, entry|
      return entry if entry.name.downcase == name_to_search_for.downcase
    end
    nil
  end

  def find_all_with_description(description_fragment)
    items_matching_description = []
    collection.each do |id, item|
      items_matching_description << item if item.description.downcase.include?(description_fragment.downcase)
    end
    items_matching_description
  end

  def find_all_by_price(price)
    items_matching_price = []
    collection.each do |id, item|
      items_matching_price << item if item.unit_price == price
    end
    items_matching_price
  end

  def find_all_by_price_in_range(range)
      range_minimum = range.first
      range_maximum = range.last
      items_matching_supplied_range = []
      collection.each do |id, item|
        items_matching_supplied_range << item if item.unit_price >= range_minimum && item.unit_price <= range_maximum
      end
    items_matching_supplied_range
  end

  def find_all_by_name(name_fragment)
    collection.reduce([]) do |all_matches, (id, entry)|
      all_matches << entry if entry.name.downcase.include?(name_fragment.downcase)
      all_matches
    end
  end

  def find_all_by_first_name(name_fragment)
    collection.reduce([]) do |all_matches, (id, entry)|
      all_matches << entry if entry.first_name.downcase.include?(name_fragment.downcase)
      all_matches
    end
  end

  def find_all_by_last_name(name_fragment)
    collection.reduce([]) do |all_matches, (id, entry)|
      all_matches << entry if entry.last_name.downcase.include?(name_fragment.downcase)
      all_matches
    end
  end

  def find_all_by_merchant_id(merchant_id)
    entries_matching_merchant_id = []
    collection.each do |id, entry|
      entries_matching_merchant_id << entry if entry.merchant_id == merchant_id
    end
    entries_matching_merchant_id
  end

  def find_all_by_customer_id(customer_id)
    collection.reduce([]) do |customer_id_matches, (id, entry)|
      customer_id_matches << entry if entry.customer_id == customer_id
      customer_id_matches
    end
  end

  def find_all_by_item_id(item_id)
    collection.reduce([]) do |item_id_matches, (id, entry)|
      item_id_matches << entry if entry.item_id == item_id
      item_id_matches
    end
  end

  def find_all_by_invoice_id(invoice_id)
    collection.reduce([]) do |invoice_id_matches, (id, entry)|
      invoice_id_matches << entry if entry.invoice_id == invoice_id
      invoice_id_matches
    end
  end

  def find_all_by_credit_card_number(credit_card_number)
    collection.reduce([]) do |matches, (id, entry)|
      matches << entry if entry.credit_card_number == credit_card_number
      matches
    end
  end

  def find_all_by_result(result)
    collection.reduce([]) do |matches, (id, entry)|
      matches << entry if entry.result == result
      matches
    end
  end

  def find_all_by_status(status)
    collection.reduce([]) do |status_matches, (id, entry)|
      status_matches << entry if entry.status == status
      status_matches
    end
  end

end
