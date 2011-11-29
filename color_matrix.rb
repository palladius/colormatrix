=begin

  implements a matrix concept, extending ruby core Matrix:
  
  http://corelib.rubyonrails.org/classes/Matrix.html

=end

require 'matrix' # from stdlib

class ColorMatrix < Array
  @@version  = "0.2" 
  @@colors = {
    :white  => 'O',
  }
  attr_accessor :x, :y
  
  def initialize(x, y, base_colour = :white )
    super(x*y, ColorMatrix.smart_color(base_colour))
    @x = x
    @y = y
    puts "Matrix initialize(#{x},#{y}) with color: #{base_colour}"
    p "DEB self.class = #{self.class}"
    #m
  end
  alias :I :initialize
  
  def colour(x,y,color)
    puts "DEB colour"
    self[x,y] = ColorMatrix.smart_color( color )
  end
  alias :L :colour
  
  def terminate()
    'TODO'
  end
  alias :X :terminate
  
  def validate
    # mockup
    return true
  end
  
  def valid?
    validate rescue false
  end
  
  def see
    puts "[SEE] This matrix has the following elements:\n"
    puts self.to_s
  end
  alias :S :see
  
  # Takes array and splits into chunks of X size
  def to_s() #(opts={})
    #str = super.to_s
    #{}"Matrix(#{x},#{y}): \n 1. #{str}\n 2. #{ str.scan(/.{#{x}}/).join(', ') }" if opts.fetch(:verbose, false)
    super.to_s.scan(/.{#{x}}/).join("\n")
  end
  
  
public

  def self.I(x,y)
    m = ColorMatrix
    m.new(x,y)
    m
  end


  
=begin
 CLASS methods !!!
=end 

  # gives the color by string itself or by hash table if its a symbol
  def self.smart_color(x)
    return @@colors[x] if x.class == Symbol
    x
  end

end #/ColorMatrix class
