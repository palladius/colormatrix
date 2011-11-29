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
  #attr_accessor :x, :y
  
  def initialize(x, y, base_colour = :white )
    Array.new(x*y, ColorMatrix.smart_color(base_colour))
    puts "Matrix initialize(#{x},#{y}) with color: #{base_colour}"
    #tmp = ColorMatrix #.new# (x,y)
    # once for every X
    #first_row = Array.new(y, ColorMatrix.smart_color(base_colour))
    p "DEB self.class = #{self.class}"
    #m
  end
  
  def colour(x,y,color)
    puts "DEB colour"
    self[x,y] = smart_color( color )
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
    puts "This matrix has the following elements:\n", self.to_s
  end
  alias :S :see
  
  def to_s
    ":TODO"
  end
  
  
public

  def self.INIT(x,y)
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
