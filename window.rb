require File.expand_path('../config/boot', __FILE__)

Dir['./lib/*.rb'].each { |file| require_relative file }
Dir['./data/*.rb'].each { |file| require_relative file }

class Window < Gosu::Window
  def initialize
    super(800, 600, false)
    self.caption = 'game'
    @shapes = []
    @camera = Camera.new(Vector.new([0, 0, 0]), Vector.new([0, 0, 1]), Vector.new([0, 1, 0]), width, height)
    materials = [Materials::EMERALD, Materials::JADE, Materials::BRONZE].cycle
    (-100...100).each do |i|
      (-100...100).each do |j|
        transform = Transform.new(Vector.new([i * 2, -2.5, j * 2]), Vector.new([2, 2, 2]))
        @shapes << GameObject.new(CubeVBO, materials.next, transform)
      end
    end
    transform1 = Transform.new(Vector.new([1, 0.5, -4]), Vector.new([3, 1, 5]), Vector.new([45.0, 45.0, 45.0]))
    transform2 = Transform.new(Vector.new([5, 5, 0]), Vector.new([1, 1, 1]))
    transform3 = Transform.new(Vector.new([-5, 1, -5]), Vector.new([3, 1, 5]))
    @cube1 = GameObject.new(CubeVBO, Materials::TURQUOISE, transform1)
    @cube2 = GameObject.new(CubeVBO, Materials::YELLOW_PLASTIC, transform2)
    @sphere = GameObject.new(Sphere, Materials::YELLOW_PLASTIC, transform3)
    @light = Light.new(GL_LIGHT0)
    @light.position = [0, 100, 0, 1]
    @light.direction = [0, -1, 0]
    transformLight = Transform.new(Vector.new(@light.position[0..3]))
    @sphereL = GameObject.new(Sphere, Materials::WHITE_LIGHT, transformLight)

    # gl do
      # CubeVBO.init()
    # end
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
      glClearColor(0, 0, 0, 1)
      glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT) # clear the screen and the depth buffer
      glEnable(GL_DEPTH_TEST)
      Light.initialize_light

      glDepthMask(GL_TRUE)
      glDepthFunc(GL_LEQUAL)
      glDepthRange(0.0, 1.0)

      @camera.initialize_projection
      @camera.initialize_view
      @light.initialize_light

      @shapes.each { |c| c.draw(@camera) }
      @cube1.draw(@camera)
      @cube2.draw(@camera)
      @sphere.draw(@camera)
      glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION, [1, 1, 1, 1])
      @sphereL.draw(@camera)
    end
  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end
end

window = Window.new
window.show
