class Vector
  include Enumerable

  attr_reader :size, :data

  X_INDEX = 0
  Y_INDEX = 1
  Z_INDEX = 2
  W_INDEX = 3

  def initialize(size)
    case size
    when Array
      @data = size
      @size = size.size
    when Integer
      @size = size
      @data = Array.new(size) { |i| yield i }
    end
  end

  def check_size(other)
    raise RangeError, 'Vector range does not match' if other.size != @size
  end

  def operateAddSub(symb, other)
    check_size(other)
    case other
    when Numeric
      operateNum(symb, other)
    when Vector
      Vector.new(@data.zip(other.data).map { |x| x.reduce(symb) })
    end
  end

  def operateNum(symb, other)
    Vector.new(@data.map { |x| x.send(symb, other) })
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
      check_size(other)
      @data.each_with_index.map { |x, i| other[i] * x }.reduce(:+)
    end
  end

  def each
    @data.each { |val| yield val }
  end

  def [](i)
    @data[i]
  end

  def []=(i, val)
    @data[i] = val
  end

  def x
    @data[X_INDEX] if size > X_INDEX
  end

  def x=(other)
    @data[X_INDEX] = other if size > X_INDEX
  end

  def y
    @data[Y_INDEX] if size > Y_INDEX
  end

  def y=(other)
    @data[Y_INDEX] = other if size > Y_INDEX
  end

  def z
    @data[Z_INDEX] if size > Z_INDEX
  end

  def z=(other)
    @data[Z_INDEX] = other if size > Z_INDEX
  end

  def w
    @data[W_INDEX] if size > W_INDEX
  end

  def w=(other)
    @data[W_INDEX] = other if size > W_INDEX
  end

  def to_f
    Vector.new(@data.map(&:to_f))
  end

  def append(x)
    arr = @data
    Vector.new(arr << x)
  end

  def norm
    @data.map { |x| x**2 }.reduce(:+)
  end

  def normalize
    self * (1.0 / norm)
  end

  def cross(other)
    arr = [nil, nil, nil]
    arr[0] = @data[1] * other[2] - @data[2] * other[1]
    arr[1] = @data[2] * other[0] - @data[0] * other[2]
    arr[2] = @data[0] * other[1] - @data[1] * other[0]
    Vector.new(arr)
  end

  def to_s
    '[' + @data.join(', ') + ']'
  end
end
