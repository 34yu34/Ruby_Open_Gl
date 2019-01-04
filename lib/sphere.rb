require_relative 'transform.rb'

class Sphere
  def self.draw
    gluSphere(gluNewQuadric, 1, 40, 40)
  end
end
