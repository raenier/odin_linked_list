require './node'

class LinkedList
  attr_accessor :head, :tail, :size

  def initialize
    self.size = 0
  end

  def append(val)
    new_node = Node.new(val)
    return attach_head_tail(new_node) if head.nil?

    self.tail.next_node = new_node
    self.tail = new_node
    self.size += 1
  end

  def prepend(val)
    new_node = Node.new(val)
    return attach_head_tail(new_node) if head.nil?

    new_node.next_node = self.head
    self.head = new_node
    self.size += 1
  end

  def at(index = 0)
    raise 'Index out of List size (out of bounds)' if index >= size

    temp_node = head
    index.times do
      temp_node = temp_node.next_node
    end
    temp_node
  end

  def pop(current_node = self.head)
    if current_node.next_node == tail
      self.size -= 1
      self.tail = current_node
      return current_node.next_node = nil
    end

    pop(current_node.next_node)
  end

  def contains?(val, current_node = self.head)
    return false if current_node.nil?
    return true if val == current_node.value

    contains?(val, current_node.next_node)
  end

  def find(val, current_node =self.head, index = 0)
    return nil if current_node.nil?
    return index if val == current_node.value

    find(val, current_node.next_node, index += 1)
  end

  def to_s(current_node = self.head)
    return 'nil' if current_node.nil?

    "( #{current_node.value} ) -> #{to_s(current_node.next_node)}"
  end

  def insert_at(val, index)
    new_node = Node.new(val)
    return set_head(new_node) if index == 0
    return set_tail(new_node) if index = size - 1

    previous_node = at(index-1)
    past_tail_nodes = previous_node.next_node
    previous_node.next_node = new_node
    previous_node.next_node.next_node = past_tail_nodes
  end

  def set_head(node)
    size += 1
    node.next_node = self.head
    self.head = node
  end

  def set_tail(node)
    size += 1
    tail.next_node = node
    self.tail = node
  end

  def remove_at(index)
    return remove_head if index == 0
    #if index is 0 we need to remove head and set a new head
    #if index is exactly at tail, we need to remove tail and set a new_tail
    previous_node = at(index-1)
    target_node = previous_node.next_node
    previous_node.next_node = target_node.next_node
  end

  def remove_head
    # if size == 2, then tail should also be set
    self.tail = head.next_node if size == 2
    self.head = head.next_node
    size -= 1
  end

  def remove_tail
    # if size == 2, then head should also be set
    at(size - 1)
    size -= 1
  end

  private

  def attach_head_tail(node)
    self.head = node
    self.tail = node
    self.size += 1
  end
end

list1 = LinkedList.new()

list1.prepend('New HEAD')
list1.prepend('New HEAD 2')
list1.append('New Tail')
list1.append('New Tail2')

p list1.to_s
p 'removing head >>>>'
list1.remove_at(0)
p list1.to_s
p list1
