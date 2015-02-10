# credit: http://eigenjoy.com/2008/02/22/ruby-inject-and-the-mandelbrot-set/
require 'complex'

def mandelbrot(a)
  Array.new(50, a).inject(a) { |z,c| z*z + c }
end

(1.0).step(-1, -0.05) do |y|
  (-2.0).step(0.5, 0.0315) do |x|
    print mandelbrot(Complex(x,y)).abs < 2 ? '*' : ' '
  end
  puts
end
