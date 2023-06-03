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

  def pop
    self.tail = at(size - 2)
    tail.next = nil
  end

  def to_s(node = head)
    return 'Nothing follows' if node.nil?

    "(#{node.value}) -> #{to_s(node.next)}"
  end
end
