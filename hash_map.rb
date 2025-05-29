require_relative "linked_list"

class HashMap
  attr_accessor :capacity
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
      list.append(key, value)
      @buckets[index] = list
    else
      node = @buckets[index].find_key(key)
      if node.nil?
        @buckets[index].append(key, value)
      else
        node.value = value
      end
    end

    if length >= @capacity*@load_factor
      @capacity = @capacity * 2

      new_buckets = Array.new(@capacity)
      @buckets.each do |bucket|
        if !bucket.nil?
          new_buckets << bucket
        end
      end

      @buckets = new_buckets
    end
  end

  def get(key)
    index = hash(key) % @capacity
    raise IndexError if index.negative? || index >= @buckets.length

    node = @buckets[index].find_key(key)
    if !node.nil?
      node
    else
      nil
    end
  end

  def has?(key)
    value = get(key)
    if value.nil?
      return false
    else
      return true
    end
  end

  def remove(key)
    index = hash(key) % @capacity
    raise IndexError if index.negative? || index >= @buckets.length

    list = @buckets[index]

    list.remove(key)
  end

  def length
    total_length = 0

    @buckets.each do |bucket|
      total_length += bucket.size if !bucket.nil?
    end

    total_length
  end

  def clear
    @buckets = Array.new(16)
  end

  def keys
    keys = []

    @buckets.each do |bucket|
      if !bucket.nil?
        bucket.each do |node|
          keys << node.key
        end
      end
    end

    keys
  end

  def values
    values = []

    @buckets.each do |bucket|
      if !bucket.nil?
        bucket.each do |node|
          values << node.value
        end
      end
    end

    values
  end

  def entries
    entries = []

    @buckets.each do |bucket|
      if !bucket.nil?
        bucket.each do |node|
          entries << "[#{node.key}, #{node.value}]"
        end
      end
    end

    entries
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

puts test.entries

test.set('lion', 'sky')
puts
puts test.entries

test.set('moon', 'silver')
system "clear"
puts test.entries
puts test.capacity