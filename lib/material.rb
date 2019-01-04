class Material
  attr_accessor :specular, :ambient, :diffuse, :shininess

  def initialize(ambient = [0, 0, 0, 0], diffuse = [1, 1, 1, 1], specular = [1, 1, 1, 1], shininess = 128)
    @specular = specular
    @ambient = ambient
    @diffuse = diffuse
    @shininess = shininess
    @emission = [0, 0, 0, 1]
  end

  def set
    glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR, @specular)
    glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT, @ambient)
    glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE, @diffuse)
    glMaterialf(GL_FRONT_AND_BACK, GL_SHININESS, @shininess)
    glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION, @emission)
  end

  def emit(arr)
    @emission = arr
    self
  end
end
