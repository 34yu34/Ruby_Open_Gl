require_relative 'vector'
require_relative 'triangle'

# singleton class
class Cube
  def self.initialize
    set_coord
  end

  def self.set_coord
    @@min = -0.5
    @@max = 0.5
    Cube.set_faces
  end

  def self.set_faces
    forward  = [Triangle.new(Vector.new([@@min, @@min, @@max]), Vector.new([@@max, @@min, @@max]), Vector.new([@@max, @@max, @@max])),
                Triangle.new(Vector.new([@@min, @@min, @@max]), Vector.new([@@max, @@max, @@max]), Vector.new([@@min, @@max, @@max]))]
    backward = [Triangle.new(Vector.new([@@min, @@min, @@min]), Vector.new([@@min, @@max, @@min]), Vector.new([@@max, @@max, @@min])),
                Triangle.new(Vector.new([@@min, @@min, @@min]), Vector.new([@@max, @@max, @@min]), Vector.new([@@max, @@min, @@min]))]
    left     = [Triangle.new(Vector.new([@@min, @@min, @@min]), Vector.new([@@min, @@min, @@max]), Vector.new([@@min, @@max, @@max])),
                Triangle.new(Vector.new([@@min, @@min, @@min]), Vector.new([@@min, @@max, @@max]), Vector.new([@@min, @@max, @@min]))]
    right    = [Triangle.new(Vector.new([@@max, @@min, @@min]), Vector.new([@@max, @@max, @@min]), Vector.new([@@max, @@max, @@max])),
                Triangle.new(Vector.new([@@max, @@min, @@min]), Vector.new([@@max, @@max, @@max]), Vector.new([@@max, @@min, @@max]))]
    under    = [Triangle.new(Vector.new([@@min, @@min, @@min]), Vector.new([@@max, @@min, @@min]), Vector.new([@@max, @@min, @@max])),
                Triangle.new(Vector.new([@@min, @@min, @@min]), Vector.new([@@max, @@min, @@max]), Vector.new([@@min, @@min, @@max]))]
    over     = [Triangle.new(Vector.new([@@min, @@max, @@min]), Vector.new([@@min, @@max, @@max]), Vector.new([@@max, @@max, @@max])),
                Triangle.new(Vector.new([@@min, @@max, @@min]), Vector.new([@@max, @@max, @@max]), Vector.new([@@max, @@max, @@min]))]
    @@faces = [over, forward, backward, left, right, under]
  end

  def self.draw
    glBegin(GL_TRIANGLES) # begin drawing model
    @@faces.each do |face|
      face.each(&:set_vertex)
    end
    glEnd
  end
end

Cube.set_coord
