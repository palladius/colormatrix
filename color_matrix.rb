=begin

  implements a matrix concept, extending ruby core Array.

	Implements all the functions required by the exercise

=end

require 'matrix' # from stdlib

class ColorMatrix < Array
  @@version  = "0.2" 
  @@colors = {
    :white  => 'O',
    :nil    => '.', # for labelling, private value
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
	# SETS COLOUR
  def set_colour(x,y,color)
		deb "set(#{x},#{y},'#{color}')"
    self[(x-1) + (y-1) * cols ] = ColorMatrix.smart_color( color )
  end
  
  # returns element(X,Y) in the array
  def get_colour(x,y)
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

  def draw_vertical(x,y1,y2,color)
    (y1..y2).each{|y| set(x,y,color) }
  end  
  
  def draw_horizontal(x1,x2,y,color)
    (x1..x2).each{|x| set(x,y,color) }
  end
  
  # 4-connectivity neighbours are: N and W
  # 8-connectivity neihbours are: W, NW, N, NE
  def half_neighbours_of(x,y)
    neighbours = []
    neighbours << [x-1,y] unless x<2 # west unless boundary
    neighbours << [x,y-1] unless y<2 # north unless boundary
    neighbours
  end
  
  def neighbours_colors_of(x,y)
    half_neighbours_of(x,y).map{|el| get(el[0],el[1]) }                    
  end

  def west?(x,y)
    x > 1
  end
  def west(x,y)
    [x-1,y] if west?
  end
  

=begin
	Fill the region R with the colour C. 
	R is defined as: Pixel (X,Y) belongs to R. 
	Any other pixel which is the same colour as (X,Y) and shares a common side with any pixel in R also belongs to this region.

	From the filling description looks like a 4-connectivity filling (I did on my thesis!)

	The solution consistes on Labelling, then filling everything which ahs the same label as the P(x,y)

	Pass 1:
		Create a matrix of boolean initialiazed to false. I reuse my matrix with true (1) and false (0)
=end
  
  
  def twopass(data)
    linked = []
    labels = ColorMatrix.new(rows,cols,:background)
    next_label = 0
    
    # First pass
    (1..rows).each do |x|
      (1..cols).each do |y|
        deb "P(#{x};#{y}) "
        if data.get(x,y) != :background
					neighbour_labels = labels.neighbours_colors_of(x,y)
					#neighbours = labels.neighbours_of(x,y)
					if neighbour_labels.size == 0 
						deb "empty neighbours!"
						linked[next_label] ||= []
						linked[next_label] << next_label
						labels.set(x,y,next_label) 
						next_label = next_label + 1       
					else # not empty
						# find the smallest label
						labels.set(x,y,neighbour_labels.min)
						deb neighbour_labels 
						deb neighbour_labels.class 
						for label in neighbour_labels do
							#deb label
							#p "union(#{ linked[label]},#{neighbour_labels})"
							linked[label] = linked[label] | neighbour_labels # union
						end
					end
				end
      end
    end
		labels.print
		# Second pass todo
  end

  def fill(x,y,color)
    #set(x,y,color)
    deb "Original matrix: \n#{self}"
    f = twopass(self)
    # First I create a labelling matrix m2
    m2 = ColorMatrix.new(self.rows,self.cols,:nil)
    #m2.set(x,y,color)
    # first pass
    labeln = 0
    (1..rows).each do |x|
      (1..cols).each do |y|
        
        #deb  "#{x},#{y}"  
        # does the pixel west have
      end
    end
    deb "Labelling matrix: \n#{m2}"
    # west
    neighbours = half_neighbours_of(x,y)
    puts "neighbours = #{neighbours}"
    
    
  end
  
  def print
    deb "[SEE] This matrix has the following elements:\n"
    puts self.to_s
  end
  
  # Takes array and splits into chunks of X size
  def to_s() #(opts={})
    super.to_s.scan(/.{#{cols}}/).join("\n")
  end
  
  alias :F :fill
	alias :H :draw_horizontal
  alias :S :print
	alias :V :draw_vertical
  alias :X :terminate
  alias :L :set_colour
  alias :I :initialize
  alias :set    :set_colour
  alias :colour :set_colour
  alias :get :get_colour

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
