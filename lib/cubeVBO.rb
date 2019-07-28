require 'gl'
require 'glu'
require 'glut'

include Gl
include Glu

class CubeVBO
  @@face = [-0.5, -0.5, 0.5,   0.5, -0.5, 0.5,   0.5, 0.5, 0.5, # forward
            -0.5, -0.5, 0.5,   0.5, 0.5, 0.5,   -0.5, 0.5, 0.5,

            -0.5, -0.5, -0.5,  -0.5, 0.5, -0.5,  0.5, 0.5, -0.5, # Backward
            -0.5, -0.5, -0.5,  0.5, 0.5, -0.5,   0.5, -0.5, -0.5,

            -0.5, -0.5, -0.5,  -0.5, -0.5, 0.5, -0.5, 0.5, 0.5, # left
            -0.5, -0.5, -0.5,  -0.5, 0.5, 0.5,  -0.5, 0.5, -0.5,

            0.5, -0.5, -0.5, 0.5, 0.5, -0.5, 0.5, 0.5, 0.5, # right
            0.5, -0.5, -0.5, 0.5, 0.5, 0.5, 0.5, -0.5, 0.5,

            -0.5, -0.5, -0.5, 0.5, -0.5, -0.5, 0.5, -0.5, 0.5, # under
            -0.5, -0.5, -0.5, 0.5, -0.5, 0.5, -0.5, -0.5, 0.5,

            -0.5, 0.5, -0.5, -0.5, 0.5, 0.5, 0.5, 0.5, 0.5, # over
            -0.5, 0.5, -0.5, 0.5, 0.5, 0.5, 0.5, 0.5, -0.5]

  @@normals = [0, 0, -1,   0, 0, -1,   0, 0, -1, # forward
               0, 0, -1,   0, 0, -1,   0, 0, -1,

               0, 0, 1,    0, 0, 1,    0, 0, 1, # Backward
               0, 0, 1,    0, 0, 1,    0, 0, 1,

               1, 0, 0,    1, 0, 0,    1, 0, 0, # left
               1, 0, 0,    1, 0, 0,    1, 0, 0,

               -1, 0, 0,    -1, 0, 0,    -1, 0, 0, # right
               -1, 0, 0,    -1, 0, 0,    -1, 0, 0,

               0, -1, 0,    0, -1, 0,    0, -1, 0, # under
               0, -1, 0,    0, -1, 0,    0, -1, 0,

               0, 1, 0,    0, 1, 0,    0, 1, 0, # over
               0, 1, 0,    0, 1, 0,    0, 1, 0]

  @@is_initialized = false

  def self.init
    if (!@@is_initialized)
      @@buf = glGenBuffers(2)
      glBindBuffer(GL_ARRAY_BUFFER, @@buf[0])
      glBufferData(GL_ARRAY_BUFFER, 108 * 4, @@face.pack('f*'), GL_STATIC_DRAW)
      glVertexPointer(3, GL_FLOAT, 0, 0)

      glBindBuffer(GL_ARRAY_BUFFER, @@buf[1])
      glBufferData(GL_ARRAY_BUFFER, 108 * 4, @@normals.pack('f*'), GL_STATIC_DRAW)
      glNormalPointer(GL_FLOAT, 0, 0)
      @@is_initialized = true;
    end
  end

  def self.draw
    init
    glEnableClientState(GL_VERTEX_ARRAY)
    glEnableClientState(GL_NORMAL_ARRAY)

    # draw a cube
    glDrawArrays(GL_TRIANGLES, 0, 108)

    glDisableClientState(GL_VERTEX_ARRAY)
    glDisableClientState(GL_NORMAL_ARRAY)

    #glDeleteBuffers(@@buf)
  end
end
