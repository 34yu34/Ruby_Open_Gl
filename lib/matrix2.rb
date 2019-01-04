require_relative 'vector.rb'

class Matrix2
  attr_reader :m, :n, :vectors

  def initialize(m, n = nil)
    case m
    when Integer
      @m = m
      @n = n
      @vectors = Array.new(m) { |i| Vector.new(n) { |j| yield(i, j) } }
    when Array
      @m = m.size
      @n = m[0].size
      @vectors = m.map { |x| Vector.new(x)  }
    when Matrix2
      @m = m.m
      @n = m.n
      @vectors = m.vectors
    end
  end

  def [](i)
    @vectors[i]
  end

  def []=(i, val)
    @vectors[i] = val
  end

  def check_size(other)
    case other
    when Matrix2
      @m == other.m && @n == other.n
    when Vector
      @m == other.size && @n == 1
    end
  end

  def operateNum(symb, other)
    data = @vectors.map { |x| x.send(symb, other) }
    prepare_return(data)
  end

  def operateAddSub(symb, other)
    case other
    when Matrix2
      data = @vectors.zip(other.vectors).map { |v| v.reduce(:+) }
      prepare_return(data)
    when Numeric
      operateNum(symb, other)
    when Vector
      raise RangeError, RangeError, 'ranges does not match' unless check_size(other)
      data = @vectors.each_with_index.map { |v, i| v[0].send(symb, other.data[i]) }
      Vector.new(data)
    end
  end

  def prepare_return(data)
    data.size == 1 ? Vector.new(data[0]) : Matrix2.new(data)
  end

  def +(other)
    operateAddSub(:+, other)
  end

  def -(other)
    operateAddSub(:-, other)
  end

  def *(other)
    case other
    when Numeric
      operateNum(:*, other)
    when Vector
      data = [[]]
      @vectors.each do |v1|
        data[0] << v1 * other
      end
      prepare_return(data)
    when Matrix2
      data = Array.new(@m) { Array.new(other.n) { 0 } }
      @vectors.each_with_index do |v1, i|
        other.vectors.each_with_index do |v2, j|
          data[i][j] = v1 * v2
        end
      end
      prepare_return(data)
    end
  end

  def to_s
    @vectors.reduce('') { |sum, x| sum + x.to_s + "\n" }
  end

  def to_f
    @vectors.map!(&:to_f)
  end

end
