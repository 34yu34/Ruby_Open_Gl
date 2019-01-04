require File.expand_path('../config/boot', __FILE__)

Dir['./lib/*.rb'].each { |file| require_relative file }
Dir['./data/*.rb'].each { |file| require_relative file }

class Window < Gosu::Window
  def initialize
    super(800, 600, false)
    self.caption = 'material testing'
    @camera = Camera.new(Vector.new([0, 0, 0]), Vector.new([0, 0, 1]), Vector.new([0, 1, 0]), width, height)
    transform = Transform.new(Vector.new([0, 0, 4]), Vector.new([1, 1, 1]), Vector.new([45.0, 45.0, 45.0]))
    material = Materials::RUBY
    @cube = Cube.new(transform, material)
    @light = Light.new(GL_LIGHT0)
    @light.position = [0, 0, 0, 1]
    @light.direction = [0, 0, 1]
    # transformLight = Transform.new(Vector.new(@light.position[0..3]))
    # @sphereL = Sphere.new(transformLight, 0.25)
  end

  def update
    @camera.move_right(0.20) if button_down? Gosu::KB_D
    @camera.move_right(-0.20) if button_down? Gosu::KB_A
    @camera.move_forward(0.20) if button_down? Gosu::KB_W
    @camera.move_forward(-0.20) if button_down? Gosu::KB_S
    @camera.move_up(0.20) if button_down? Gosu::KB_X
    @camera.move_up(-0.20) if button_down? Gosu::KB_Z
    @camera.rotate_x(0.1) if button_down? Gosu::KB_Y
    @camera.rotate_x(-0.1) if button_down? Gosu::KB_U
    @camera.rotate_z(0.1) if button_down? Gosu::KB_O
    @camera.rotate_z(-0.1) if button_down? Gosu::KB_P
    @camera.rotate_y(0.1) if button_down? Gosu::KB_Q
    @camera.rotate_y(-0.1) if button_down? Gosu::KB_E
  end

  def draw
    gl do
      glClearColor(0.1, 0.1, 0.1, 1)
      glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT) # clear the screen and the depth buffer
      glEnable(GL_DEPTH_TEST)
      Light.initialize_light

      glDepthMask(GL_TRUE)
      glDepthFunc(GL_LEQUAL)
      glDepthRange(0.0, 1.0)

      @camera.initialize_view
      @camera.initialize_projection
      @light.initialize_light

      @cube.draw(@camera)
    end
  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end
end

window = Window.new
window.show
