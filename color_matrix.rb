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

	def	deb(str)
		puts "DEB| #{str}" if @@debug
	end
  
  # P(x,y) in human/math notation corresponds to
  # x-1 for X and y'1 for Y in matrix notation.
  # which is (x-1)+(y-1)*NUM_COLUMNS in streteched array notation
  def colour(x,y,color)
    self[(x-1) + (y-1) * cols ] = ColorMatrix.smart_color( color )
  end
  
  # returns element(X,Y) in the array
  def get(x,y)
    self[(x-1) + (y-1) * cols ]
  end
  
  def terminate()
    'TODO'
  end
  
  def validate
    # mockup
    return true
  end
  
  def valid?
    validate rescue false
  end

	def	draw_vertical(x,y1,y2,color)
		:TODO
	end
	def	draw_horizontal(x1,x2,y,color)
		:TODO
	end

	def fill(x,y,color)

	end
  
  def see
    deb "[SEE] This matrix has the following elements:\n"
    puts self.to_s
  end
  
  # Takes array and splits into chunks of X size
  def to_s() #(opts={})
    super.to_s.scan(/.{#{cols}}/).join("\n")
  end
  
  alias :F :fill
	alias :H :draw_horizontal
  alias :S :see
	alias :V :draw_vertical
  alias :X :terminate
  alias :L :colour
  alias :I :initialize

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
