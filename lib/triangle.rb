class Triangle
  attr_accessor :pts, :normal
  include Enumerable

  def initialize(pts1, pts2, pts3)
    @pts = [pts1, pts2, pts3]
    @normal = (pts2 - pts3).cross(pts2 - pts1)
  end

  def set_vertex
    glNormal3f(@normal.x, @normal.y, @normal.z)
    glVertex3f(@pts[0].x, @pts[0].y, @pts[0].z)
    glVertex3f(@pts[1].x, @pts[1].y, @pts[1].z)
    glVertex3f(@pts[2].x, @pts[2].y, @pts[2].z)
  end

  def to_a
    [@pts[0].x, @pts[0].y, @pts[0].z,
     @pts[1].x, @pts[1].y, @pts[1].z,
     @pts[2].x, @pts[2].y, @pts[2].z]
  end

  def normal_array
    [@normal.x, @normal.y, @normal.z,
     @normal.x, @normal.y, @normal.z,
     @normal.x, @normal.y, @normal.z]
  end

  def each
    @pts.each { |pt| yield(pt) }
  end
end
