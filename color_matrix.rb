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
		#deb "set(#{x},#{y},'#{color}')"
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
  def neighbours_of(x1,y1)
    myneighbours = [ ]
    #myneighbours = [ [-5, -6] ]
    myneighbours << [(x1-1),(y1)] # unless x<2 # west unless boundary
    myneighbours << [(x1),(y1-1)] # unless y<2 # north unless boundary
    #neighbours << [x+1,y] unless x >= cols # east unless boundary
    #neighbours << [x,y+1] unless y >= rows # south unless boundary
		deb "Neighbours of (#{x1},#{y1}): #{myneighbours.inspect}"
    myneighbours
  end
  
  def neighbours_colors_of(x,y)
    neighbours_of(x,y).map{|el| get(el[0],el[1]) }                    
  end


=begin
	Fill the region R with the colour C. 
	R is defined as: Pixel (X,Y) belongs to R. 
	Any other pixel which is the same colour as (X,Y) and shares a common side with any pixel in R also belongs to this region.

	From the filling description looks like a 4-connectivity filling (I did on my thesis!).

	This is known in literature as "Connected component labeling" or "4/8-connectivity labelling".

	The solution consistes on Labelling, then filling everything which has the same label as the P(x,y)

	Pass 1:
		Create a matrix of boolean initialiazed to false (or int to 0). I reuse my matrix with true (1) and false (0)
=end
 
  
  def twopass(data)
    linked = []
    labels = ColorMatrix.new(rows,cols,0)
    next_label = 0  #  0 is background, we start with 1
		deb "data: #{data}"
    
    # First pass
    (1..rows).each do |y|
      (1..cols).each do |x|
        #deb "P(#{x};#{y}) "
        if data.get(x,y) != 0
					neighbours = labels.neighbours_of(x,y)
					neighbours_filtered = labels.neighbours_of(x,y).select{|el| # el is an array(x,y) 
						deb "Andrea EL #{el[0]},#{el[1]} vs #{x},#{y} -- #{el.inspect}"
						#labels.get(el[0],el[1]) == labels.get(x,y)
						labels.get(el[0],el[1]) == data.get(x,y)
					}
					neighbour_labels = labels.neighbours_colors_of(x,y)
					#	Neighbours are the elements which are connected with the current elements label
					deb "P=(#{x},#{y}) Neighbours => #{neighbours.inspect}; Labels: #{neighbour_labels.join(', ')}"
					if neighbours_filtered == []
						#deb "empty neighbours!"
						linked[next_label] ||= []
						linked[next_label] << next_label
						labels.set(x,y,next_label) 
						next_label = next_label + 1       
					else # not empty
						# find the smallest label
						#deb "Not empty! P=(#{x},#{y}) Neighbours => #{neighbours.inspect}; Labels: #{neighbour_labels.join(', ')}"
						labels.set(x,y,neighbour_labels.min)
						#deb neighbour_labels 
						#deb neighbour_labels.class 
						for label in neighbour_labels do
							#deb label
							#p "union(#{ linked[label]},#{neighbour_labels})"
							linked[label] = linked[label] | neighbour_labels # union
							#deb "Linked now is: #{linked.inspect}"
						end
					end
				end
      end
    end
		
		# debug print intermedium
		labels.print "First labelling pass"

		# Second pass todo
    (1..rows).each do |y|
      (1..cols).each do |x|
        if data[x][y] != 0
					labels.set(x,y, _find(labels[x][y]) )
				end
			end
		end
		labels.print "after second pass"
	
		return labels
  end

	def _find(s)
		s.to_i
	end

  def fill(x,y,color)
    deb "Original matrix: \n#{self}"
    m2 = twopass(self)
		label_xy = m2.get(x,y)
		deb "Label from my point: #{label_xy}"
    #set(x,y,color)
    (1..rows).each do |x1|
      (1..cols).each do |y1|
				set(x1,y1,color) if m2.get(x1,y1) == label_xy
			end
		end

    # First I create a labelling matrix m2
    #m2 = ColorMatrix.new(self.rows,self.cols,:nil)
    #deb "Labelling matrix: \n#{m2}"
    
  end

	# set all pixels to white
	def clear()
    (1..rows).each do |x|
      (1..cols).each do |y|
			end
		end
	end
  
  def print(description = "This matrix has the following elements")
    deb "[PRINT] #{description}\n"
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

	def self.deb?
		@@debug
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
