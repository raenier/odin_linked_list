require_relative 'node'

class LinkedList
  attr_accessor :head, :tail

  def initialize
    @head = nil
    @tail = nil
  end

  def prepend(value)
    new_node = Node.new(value)
    if head.nil?
      self.head = new_node
      self.tail = new_node
    else
      new_node.next = head
      self.head = new_node
    end
  end

  def append(value)
    new_node = Node.new(value)
    tail.next = new_node
    self.tail = new_node
  end

  def size(node = head)
    return 1 if node.next.nil?

    #recursively traversing the list starting from the head node
    sum = 1 + size(node.next)
  end

  def at(index, node = head)
    return node if index == 0

    at(index - 1, node.next)
  end

  def insert_at(value, index)
    return prepend(value) if index == 0
    return append(value) if index == size - 1
    return nil if index >= size

    new_node = Node.new(value)
    next_node = at(index)
    prev_node = at(index - 1)
    new_node.next = next_node
    prev_node.next = new_node
  end

  def remove_at(index)
    return nil if index >= size
    return pop if index == size - 1
    return self.head = at(1) if index == 0

    prev_node = at(index - 1)
    prev_node.next = at(index + 1)
  end

  def pop
    self.tail = at(size - 2)
    tail.next = nil
  end

  def contains?(value, node=head)
    return true if value == node.value
    return false if node.next.nil?

    contains?(value, node.next)
  end

  def find(value)
    return nil unless contains?(value)

    ctr = 0
    size.times do |i|
      break if at(i).value == value
      ctr += 1
    end
    return ctr
  end

  def to_s(node = head)
    return 'Nothing follows' if node.nil?

    "(#{node.value}) -> #{to_s(node.next)}"
  end
end
