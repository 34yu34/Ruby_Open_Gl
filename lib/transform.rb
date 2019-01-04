# require "math"

class Transform
  attr_accessor :position, :scale, :angle

  def initialize(position = Vector.new([0,0,0]), scale = Vector.new([1,1,1]), angle = Vector.new([0,0,0]))
    @angle = angle
    @pos = position
    @scale = scale
  end

  def set
    glTranslatef(@pos.x, @pos.y, @pos.z)
    glRotatef(@angle.x, 1.0, 0.0, 0.0)
    glRotatef(@angle.y, 0.0, 1.0, 0.0)
    glRotatef(@angle.z, 0.0, 0.0, 1.0)
    glScalef(@scale.x, @scale.y, @scale.z)
  end

  def to_s
  "angle: #{@angle.to_s}\nposition:#{@pos.to_s}\nscale:#{@scale.to_s}"
  end
end
