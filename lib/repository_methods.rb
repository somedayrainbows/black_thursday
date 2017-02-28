# refactor: move the csv reading into sales engine
require 'pry'

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

  def find_all_by_name(name_fragment)
    collection.reduce([]) do |all_matches, (id, entry)|
      all_matches << entry if entry.name.downcase.include?(name_fragment.downcase)
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

  def find_all_by_status(status)
    collection.reduce([]) do |status_matches, (id, entry)|
      status_matches << entry if entry.status == status
      status_matches
    end
  end

end
