class GlColor
  attr_accessor :a

  def self.WHITE
    GlColor.new(255, 255, 255, 1)
  end

  def self.BLACK
    GlColor.new(0, 0, 0, 1)
  end

  def self.RED
    GlColor.new(255, 0, 0, 1)
  end

  def self.GREEN
    GlColor.new(0, 255, 0, 1)
  end

  def self.BLUE
    GlColor.new(0, 0, 255, 1)
  end


  def initialize(r=0, g=0, b=0, a = 1.0)
    @r = r.to_f / 255.0
    @g = g.to_f / 255.0
    @b = b.to_f / 255.0
    @a = a
  end
  
  def r=(val)
    @r = r.to_f / 255.0
  end

  def g=(val)
    @g = g.to_f / 255.0
  end

  def b=(val)
    @b = b.to_f / 255.0
  end

  def r
    @r * 255
  end

  def g
    @g * 255
  end

  def b
    @b * 255
  end

  def set_gl_color
    glColor4f(@r, @g, @b, @a) # sets color to be used using RBG
  end

  def to_s
    "{#{@r*255},#{@g*255},#{@b*255}}"
  end
end
