require File.expand_path('../config/boot', __FILE__)

Dir['./lib/*.rb'].each { |file| require_relative file }
Dir['./data/*.rb'].each { |file| require_relative file }

class Window < Gosu::Window
  def initialize
    super(800, 600, false)
    self.caption = 'game'
    @shapes = []
    @camera = Camera.new(Vector.new([0, 0, 0]), Vector.new([0, 0, 1]), Vector.new([0, 1, 0]), width, height)
    @light = Light.new(GL_LIGHT0)
    @light.position = [0, 100, 0, 1]
    @light.direction = [0, -1, 0]
    transformLight = Transform.new(Vector.new(@light.position[0..3]))
    @sphereL = GameObject.new(Sphere, Materials::WHITE_LIGHT, transformLight)
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

      # z = glGenVertexArrays(1)
      # glBindVertexArray(z[0])

      glDepthMask(GL_TRUE)
      glDepthFunc(GL_LEQUAL)
      glDepthRange(0.0, 1.0)

      vertices = [
        1, 0, 5,  -1, 0, 5,    0, 1, 5,
        1, 0, 5,   0, 0, 6,    0, 1, 5,
        0, 0, 6,   0, 1, 5,   -1, 0, 5,
        1, 0, 5,   0, 0, 6,   -1, 0, 5
      ]
      normals = [
        0, 0, 1,   0, 0, 1,    0, 0, 1,
        1, 1, -1,  1, 1, -1,   1, 1, -1,
        -1, 1, -1, -1, 1, -1,  -1, 1, -1,
        0, -1, 0,  0, -1, 0,   0, -1, 0
      ]
      # colors = [
      # 1, 0, 0,
      # 1, 0, 0,
      # 1, 0, 0,
      # 1, 0, 0
      # ]

      buf = glGenBuffers(2)

      # activate and specify pointer to vertex array
      @camera.initialize_projection
      @camera.initialize_view
      @light.initialize_light

      glEnableClientState(GL_VERTEX_ARRAY)
      # glEnableClientState(GL_COLOR_ARRAY)
      # glEnableClientState(GL_INDEX_ARRAY)
      glEnableClientState(GL_NORMAL_ARRAY)

      glBindBuffer(GL_ARRAY_BUFFER, buf[0])
      glBufferData(GL_ARRAY_BUFFER, 36 * 4, vertices.pack('f*'), GL_DYNAMIC_DRAW)
      glVertexPointer(3, GL_FLOAT, 0, 0)

      glBindBuffer(GL_ARRAY_BUFFER, buf[1])
      glBufferData(GL_ARRAY_BUFFER, 4 * 36, normals.pack('f*'), GL_DYNAMIC_DRAW)
      glNormalPointer(GL_FLOAT, 0, 0)
      # glColorPointer(3, GL_FLOAT, 0, 0)

      # draw a cube
      Materials::JADE.set
      glDrawArrays(GL_TRIANGLES, 0, 36)
      # glDrawArrays(GL_TRIANGLES, 0, 9)

      # deactivate vertex arrays after drawing
      glDisableClientState(GL_VERTEX_ARRAY)
      glDisableClientState(GL_NORMAL_ARRAY)
      # glDisableClientState(GL_COLOR_ARRAY)
      # glDisableClientState(GL_INDEX_ARRAY)

      glDeleteBuffers(buf)
      glBindBuffer(GL_ARRAY_BUFFER, 0)
      # glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0)
    end
  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end
end

window = Window.new
window.show
