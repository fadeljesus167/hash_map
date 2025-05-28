require_relative "linked_list"

class HashMap
  def initialize
    @capacity = 16
    @load_factor = 0.8
    @buckets = Array.new(@capacity)
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end

  def set(key, value)
    index = hash(key) % @capacity
    raise IndexError if index.negative? || index >= @buckets.length

    if @buckets[index].nil?
      list = LinkedList.new
      list.append(value)
      @buckets[index] = list
    else
      @buckets[index].append(value)
    end
  end

  def get(key)
    index = hash(key) % @capacity
    raise IndexError if index.negative? || index >= @buckets.length

    @buckets[index]
  end

  def has?(key)
    value = get(key)
    if value.nil?
      return false
    else
      return true
    end
  end
end

test = HashMap.new

test.set('apple', 'red')
test.set('banana', 'yellow')
test.set('carrot', 'orange')
test.set('dog', 'brown')
test.set('elephant', 'gray')
test.set('frog', 'green')
test.set('grape', 'purple')
test.set('hat', 'black')
test.set('ice cream', 'white')
test.set('jacket', 'blue')
test.set('kite', 'pink')
test.set('lion', 'golden')

puts test.has?('kite')