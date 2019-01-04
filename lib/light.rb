class Light
  attr_accessor :ambient, :diffuse, :specular, :position, :direction
  def initialize(light, _position = [0, 0, 0, 0])
    @light = light
    initialize_pos
  end

  def initialize_pos
    @ambient = [0, 0, 0, 1] # ambient light - lights all objects on the scene equally, format is RGBA
    @diffuse = [1, 1, 1, 1] # diffuse light is created by the light source and reflects off the surface of an object, format is also RGBA
    @specular = [1, 1, 1, 1] # specular
    @position = [0, 5, 0, 1] # position of the light source from the current point
    @direction = [0, -1, 0]
  end

  def self.initialize_light
    glEnable(GL_NORMALIZE)
    glEnable(GL_LIGHTING) # enables / disables lighting of the scene based on light switch
    glShadeModel(GL_SMOOTH) # selects smooth shading
    glLightModelfv(GL_LIGHT_MODEL_AMBIENT, [0.2, 0.2, 0.2, 1])
    glLightModelf(GL_LIGHT_MODEL_COLOR_CONTROL, GL_SEPARATE_SPECULAR_COLOR)
    glLightModelf(GL_LIGHT_MODEL_LOCAL_VIEWER, 1)
  end

  def initialize_light
    glEnable(@light) # enables prepared light source
    glLightfv(@light, GL_AMBIENT, @ambient) # sets ambient light for light source
    glLightfv(@light, GL_DIFFUSE, @diffuse) # sets diffuse light for light source
    glLightfv(@light, GL_SPECULAR, @specular) # sets specular light for light source
    glLightfv(@light, GL_POSITION, @position) # sets position of light
    if position[4] == 1
      glLightfv(@light, GL_SPOT_DIRECTION, @direction) # sets spotlight dir of light
      glLightfv(@light, GL_SPOT_EXPONENT, [0]) # sets spotlight intensities of light
      glLightfv(@light, GL_SPOT_CUTOFF, [70]) # sets spotlight area angle of light
      glLightfv(@light, GL_CONSTANT_ATTENUATION, [1, 0, 0]) # sets spotlight area angle of light
    end
  end
end
