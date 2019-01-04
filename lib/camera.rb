class Camera
  attr_reader :matrix

  def initialize(pos, look_at = nil, up = nil, width, height)
    @pos = pos
    @look_at = look_at ? look_at : @pos + Vector.new([0, 0, 1])
    @up = up ? up.normalize : Vector.new([1, 0, 0])
    set_dir
    @width = width
    @height = height
  end

  def set_dir
    @forward = (@look_at - @pos).normalize
    @right = @forward.cross(@up).normalize
  end

  def move_forward(val)
    vs = @forward * val
    @pos += vs
    set_look_at
  end

  def move_up(val)
    vs = @up * val
    @pos += vs
    set_look_at
  end

  def move_right(val)
    vs = @right * val
    @pos += vs
    set_look_at
  end

  def rotate_x(angleX)
    rx = Matrix2.new([
                       [1, 0, 0],
                       [0, Math.cos(angleX), -Math.sin(angleX)],
                       [0, Math.sin(angleX), Math.cos(angleX)]
                     ])
    @forward = rx * @forward
    @look_at = @pos + @forward
    @up = rx * @up
    set_dir
    self
  end

  def rotate_y(angleY)
    ry = Matrix2.new([
                       [Math.cos(angleY), 0.0, Math.sin(angleY)],
                       [0.0, 1.0, 0.0],
                       [-Math.sin(angleY), 0.0, Math.cos(angleY)]
                     ])
    @forward = ry * @forward
    @look_at = @pos + @forward
    @up = ry * @up
    set_dir
    self
  end

  def rotate_z(angleZ)
    rz = Matrix2.new([
                       [Math.cos(angleZ), -Math.sin(angleZ), 0],
                       [Math.sin(angleZ), Math.cos(angleZ), 0],
                       [0, 0, 1]
                     ])
    @forward = rz * @forward
    @look_at = @pos + @forward
    @up = rz * @up
    set_dir
    self
  end

  def set_look_at
    @look_at = @pos + @forward
    self
  end

  def initialize_projection
    glMatrixMode(GL_PROJECTION)
    glLoadIdentity
    gluPerspective(45.0, @width / @height, 0.1, 100.0)
  end

  def initialize_view
    glMatrixMode(GL_MODELVIEW)
    glLoadIdentity
    gluLookAt(@pos.x, @pos.y, @pos.z,
              @look_at.x, @look_at.y, @look_at.z,
              @up.x, @up.y, @up.z)
  end
end
