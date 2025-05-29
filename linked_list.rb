class Node
  attr_accessor :key, :value, :next_node

  def initialize
    @key = nil
    @value = nil
    @next_node = nil
  end
end

class LinkedList
  def initialize
    @head = Node.new
  end

  def append(key, value)
    if @head.value.nil?
      @head.key = key
      @head.value = value
    elsif @head.next_node.nil?
      node = Node.new
      node.key = key
      node.value = value
      @head.next_node = node
    else
      node = @head.next_node
      while !node.next_node.nil?
        node = node.next_node
      end
      new_node = Node.new
      node.key = key
      new_node.value = value
      node.next_node = new_node
    end
  end

  def prepend(value)
    if @head.value.nil?
      @head.value = value
    elsif @head.next_node.nil?
      node = Node.new
      node.value = value
      @head.next_node = node
    else
      previuos_node = @head.next_node
      new_node = Node.new
      new_node.value = value
      new_node.next_node = previuos_node
      @head.next_node = new_node
    end
  end

  def size
    if @head.value.nil?
      return 0
    else
      node = @head
      list_size = 1
      while !node.next_node.nil?
        list_size = list_size + 1
        node = node.next_node
      end
      
      return list_size
    end
  end

  def head
    return @head
  end

  def tail
    if @head.value.nil?
      return nil
    else
      node = @head
      while !node.next_node.nil?
        node = node.next_node
      end
      
      return node.value
    end
  end

  def at(index)
    node = @head

    if index > size
      return "Index out of range"
    else
      node = @head
      for i in 1..index-1
        node = node.next_node
      end

      return node
    end
  end

  def pop
    node = at(size-1)
    pop_node = node.next_node
    node.next_node = nil

    return pop_node
  end

  def each
    node = @head
    size.times do
      yield(node)
      node = node.next_node
    end
  end

  def remove(key)
    node = @head
    previuos_node = nil

    if node.key.eql?(key)
      @head = @head.next_node
    else
      while !node.next_node.nil?
        previuos_node = node
        node = node.next_node

        if node.key.eql?(key)
          previuos_node.next_node = node.next_node
          return "Deleted"
        elsif previuos_node.key.eql?(key)
          previuos_node = node
          return "Deleted"
        end
      end
    end

    "No key has been found"
  end

  def contains?(value)
    node = @head
    
    while !node.nil?
      if node.value.eql?(value)
        return true
      end

      node = node.next_node
    end

    return false
  end

  def find(value)
    node = @head

    while !node.nil?
      if node.value.eql?(value)
        return node
      end

      node = node.next_node
    end

    return "Node not found"
  end

  def find_key(key)
    node = @head

    while !node.nil?
      if node.key.eql?(key)
        return node
      end

      node = node.next_node
    end

    return nil
  end

  def to_s
    str = ""
    node = @head

    while !node.nil?
      str << "( #{node.value} ) - > "
      node = node.next_node
    end

    str << "nil"
  end
end