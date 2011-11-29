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
	@@debug = true
  attr_accessor :cols, :rows
  
  def initialize(x, y, base_colour = :white )
    super(x*y, ColorMatrix.smart_color(base_colour))
    @cols = x
    @rows = y
    deb "Matrix initialize(#{x},#{y}) with color: #{base_colour}"
  end
  alias :I :initialize

	def	deb(str)
		puts "DEB| #{str}" if @@debug
	end
  
  # P(x,y) in human/math notation corresponds to
  # x-1 for X and y'1 for Y in matrix notation.
  # which is (x-1)+(y-1)*NUM_COLUMNS in streteched array notation
  def colour(x,y,color)
    self[(x-1) + (y-1) * cols ] = ColorMatrix.smart_color( color )
  end
  alias :L :colour
  
  # returns element(X,Y) in the array
  def get(x,y)
    self[(x-1) + (y-1) * cols ]
  end
  
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
    deb "[SEE] This matrix has the following elements:\n"
    puts self.to_s
  end
  alias :S :see
  
  # Takes array and splits into chunks of X size
  def to_s() #(opts={})
    super.to_s.scan(/.{#{cols}}/).join("\n")
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
private
  # gives the color by string itself or by hash table if its a symbol
  def self.smart_color(x)
    return @@colors[x] if x.class == Symbol
    x
  end

end #/ColorMatrix class
