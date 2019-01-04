class GameObject
  attr_accessor :shape, :material, :transform

  def initialize(shape, material, transform)
    @shape = shape
    @material = material
    @transform = transform
  end

  def draw(camera)
    camera.initialize_view
    @material.set
    @transform.set
    @shape.draw
  end
end
