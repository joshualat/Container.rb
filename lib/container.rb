require 'container/version'

class Container
  include Enumerable
  attr_accessor :array, :hash

  def initialize
    @array = []
    @hash = Hash.new { NullObject.new }
  end

  def empty?
    @array.empty? && @hash.empty?
  end

  def each(&block)
    @array.each do |member|
      block.call(member)
    end
  end

  def <<(value)
    @array << value
  end

  def push(value)
    @array.push(value)
  end

  def [](key)
    if key.is_a?(Numeric)
      safe @array[key]
    else
      safe @hash[key]
    end
  end

  def safe(value)
    if value.nil?
      NullObject.new
    else
      value
    end
  end

  def []=(key, value)
    if key.is_a?(Numeric)
      @array[key] = value
    else
      @hash[key] = value
    end
  end

  def to_hash(*allowed_keys)
    output_hash = Hash.new { NullObject.new }

    if allowed_keys.empty?
      # return all keys symbolized
      @hash.each do |key, value|
        output_hash[key.to_sym] = value
      end
    else
      @hash.each do |key, value|
        key_sym = key.to_sym
        if allowed_keys.include?(key_sym)
          output_hash[key_sym] = value
        end
      end
    end

    output_hash
  end

  def set(note = '')
    yield(self)

    self
  end

  def method_missing(method_sym, *arguments, &block)
    method_last_char = method_sym[-1]
    hash_key = method_sym.to_s.gsub('?','').gsub('=','').to_sym
  
    if method_last_char == '='
      @hash[hash_key] = arguments.first
    else
      if @hash.keys.include?(hash_key)
        return_value = @hash[hash_key]

        if return_value.nil?
          NullObject.new
        else
          return_value
        end
      else
        NullObject.new
      end
    end
  end

  class NullObject
    def nil?
      true
    end

    def empty?
      true
    end

    def blank?
      true
    end

    def to_s
      ""
    end

    def to_str
      ""
    end

    def !
      true
    end

    def method_missing(method_sym, *arguments, &block)
      return NullObject.new
    end

    def self.wrap(instance)
      class << instance
        def method_missing(method_sym, *arguments, &block)
          return NullObject.new
        end
      end

      instance
    end
  end
end