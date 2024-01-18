class Linkedlist
    attr_accessor :size, :tail, :head
    def initialize
      @size = 0
      @tail = nil
      @head = nil
    end
  
    def append(value)
      node = Node.new
      @size += 1
      @tail.next = node unless @tail.nil?
      if @head.nil? then @head = node end
      @tail = node
      node.value(value)
      node
    end
    
    def prepend(value)
      node = Node.new
      @size += 1
      node.next = @head unless @head.nil?
      if @head.nil? then @head = node end
      @head = node
      node.value(value)
      node
    end
    
    def size
      @size
    end
  
    def head
      @head.content
    end
    
    def tail
      @tail.content
    end

    def get_keys
      pointer = 0
      content = @head
      keys = []
      while pointer < @size
        if content.nil? then break end
          keys.push(content.content[0])
        content = content.next_node
        pointer += 1
      end
      keys
      end

    def get_values
      pointer = 0
      content = @head
      values = []
      while pointer < @size
        if content.nil? then break end
          values.push(content.content[1])
        content = content.next_node
        pointer += 1
      end
      values
      end
  
    def at(index)
      pointer = 0
      return nil if index >= @size
      content = @head
      while pointer != index
        if content.nil? then break end
        content = content.next_node
        pointer += 1
      end
      content
      end
    
    def pop
      previous = self.at(@size -2)
      previous.instance_variable_set(:@next,nil)
      @tail = previous
      @size -= 1
    end

    def contains_key?(key)
      pointer = 0
      while pointer < @size
        content = self.at(pointer).content[0]
        if content == key then return true end
        pointer += 1
      end
      false
    end
  
    def contains?(value)
      pointer = 0
      while pointer < @size
        content = self.at(pointer).content
        if content == value then return true end
        pointer += 1
      end
      false
    end

    def find_key(key)
      if @head.nil? then nil end
      pointer = 0
      while pointer < @size
        content = self.at(pointer)
        unless content.nil?
          content = content.content[0]
        end
        if content == key then return pointer end
        pointer += 1
      end
      nil
    end
  
    def find(value)
      pointer = 0
      while pointer < @size
        content = self.at(pointer).content
        if content == value then return pointer end
        pointer += 1
      end
      nil
    end
  
    def to_s
      pointer = 0
      while pointer < @size
        content = self.at(pointer)
        print "#{content.content} -> " unless content.nil?      
        pointer += 1
      end
    end
  
    def insert_at(value,index)
      if index > @size+1 || index < 0 then return puts "Out of bounds" end
      if index == 0 then return self.prepend(value) end
      if index == @size+1 then return self.append(value) end
      previous_node = self.at(index-1)
      next_node = self.at(index)
      node = Node.new
      node.value(value)
      previous_node.instance_variable_set(:@next,node)
      node.instance_variable_set(:@next,next_node)
      @size += 1
    end

    def remove_head
      if @size > 1
        old_node = @head
        new_node = @head.next
        old_node.next = nil
        @head = new_node
      else
        @head = nil
      end
      @size -=1
    end
  
    def remove_at(index)
      if index > @size+1 || index < 0 then return puts "Out of bounds" end
      if index == 0 then return self.remove_head end
      previous_node = self.at(index-1)
      next_node = self.at(index+1)
      node = self.at(index)
      previous_node.instance_variable_set(:@next,next_node)
      node.instance_variable_set(:@next,nil)
      @size -= 1
    end
    
  end
  
  class Node < Linkedlist
    attr_accessor :next, :content

    def initialize
      @next = nil
      @content = ""
    end
    
    def value(input = "")
      if input != ""
      @content = input
      end
      @content
    end
    def next_node
      @next
    end
  end