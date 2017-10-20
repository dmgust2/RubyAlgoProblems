require "json"

module Products

  def self.sort_by_price_ascending(json_string)
    parsed_json_array = JSON.parse(json_string)
    p parsed_json_array

    #sorted_list = parsed_json_array.sort_by { | item | item["price"] }
    # How to sort alpha by name if price is the same??
    sorted_list = parsed_json_array.sort_by { | item | [ item["price"],
                                                         item["name"] ] }

    return sorted_list.to_json
  end

end

# Test 0
puts Products.sort_by_price_ascending('[{"name":"eggs","price":1},{"name":"coffee","price":9.99},{"name":"rice","price":4.04}]')
puts

# Test 1
puts Products.sort_by_price_ascending('[{"name":"A","price":1},{"name":"D","price":9.99},{"name":"b","price":9.99}]')
puts