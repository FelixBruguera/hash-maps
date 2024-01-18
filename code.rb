require_relative 'linked_lists'
class HashMap

    def initialize
    @bucket = Array.new(16)
    end

    def string_to_number(string)
        hash_code = 0
        prime_number = 31
        string.each_char { |char| hash_code = prime_number * hash_code + char.ord }
        hash_code
      end

    def hash(key)
        string_to_number(key) % @bucket.length
      end

    def set(key, value)
        if @bucket.filter {|elem| elem != nil}.length >= @bucket.length*0.75
            new_bucket = Array.new(@bucket.length*2)
            @bucket = @bucket + new_bucket
        end
        index = hash(key)
        list = @bucket.at(index)
        if list.nil?
            @bucket.delete_at(index)
            node = Linkedlist.new
            node.append([key,value])
            @bucket.insert(index, node)
        elsif list.size > 1
            find_key = list.find_key(key)
            if find_key != nil
                list.remove_at(find_key)
                list.insert_at([key, value], find_key)
            else
                list.append([key, value])
            end
        else
            if list.head[0] == key
                list.remove_at(0)
                list.insert_at([key, value], 0)
            else
                list.append([key, value])
            end
        end
    end

    def get(key)
        value = @bucket.at(hash(key))
        find_key = value.find_key(key)
        if find_key.nil? then nil else value.at(find_key).content end
    end

    def key?(key)
        clean_bucket = @bucket.filter {|elem| elem != nil}
        clean_bucket.any? {|list| list.contains_key?(key)}
    end

    def remove(key)
        list = @bucket.at(hash(key))
        if list.nil? then return nil end
        find_key = @bucket.at(hash(key)).find_key(key)
        if find_key.nil?
            return nil
        elsif list.size > 1
            content = @bucket.at(hash(key)).at(find_key).content[1]
            @bucket.at(hash(key)).remove_at(find_key)
            @bucket.insert(hash(key), nil)
            content
        else
            content = @bucket.at(hash(key)).at(find_key).content[1]
            @bucket.delete_at(hash(key))
            @bucket.insert(hash(key), nil)
            content
        end
    end

    def length
        total = 0
        clean_bucket = @bucket.filter {|elem| elem != nil}
        clean_bucket.each {|list| total += list.size}
        total
    end

    def clear
        @bucket = Array.new(16)
    end

    def keys
        arr = []
        clean_bucket = @bucket.filter {|elem| elem != nil}
        clean_bucket.each {|list| arr.push(list.get_keys)}
        arr.flatten
    end

    def values
        arr = []
        clean_bucket = @bucket.filter {|elem| elem != nil}
        clean_bucket.each {|list| arr.push(list.get_values)}
        arr.flatten
    end

    def entries
        arr = []
        keys = self.keys
        values = self.values
        for i in 0..(keys.length-1)
            arr.push([keys[i], values[i]])
        end
        arr
    end

end