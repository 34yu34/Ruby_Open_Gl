Dir['./lib/*.rb'].each { |file| require_relative file }

a = Vector.new(4) {|i| i}
b = Vector.new([1,2,3,4])
c = Vector.new(8) {|j| j**2}

d = Matrix2.new(4,4) {|i,j| i + j}
e = Matrix2.new(4,1) {|i,j| (i+1) * (j+1)}
f = Matrix2.new(4,4) {|i,j| i == j ? 1 : 0}

puts e + b
