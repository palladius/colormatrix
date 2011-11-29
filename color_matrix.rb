=begin

  implements a matrix concept, extending ruby core Array.

	Implements all the functions required by the exercise

=end

require 'set' # from stdlib

class ColorMatrix < Array
  @@version  = "0.2" 
  @@colors = {
    :white  => 'O',
    :nil    => '.', # for labelling, private value
    :background  => '0' , # for labelling, private value
  }
	@@debug = false
  attr_accessor :cols, :rows
  
  def initialize(x, y, base_colour = :white )
    super(x*y, ColorMatrix.smart_color(base_colour))
    @cols = x
    @rows = y
    deb "Matrix initialize(#{rows}x#{cols}) with color: #{base_colour}"
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
    puts 'only makes sense in interactive mode..'
		exit 0
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
  # 8-connectivity neighbours are: W, NW, N, NE   (diagonal_also)
  def neighbours_of(x,y, diagonal_also = false)
    myneighbours = [ ]
    myneighbours << [x-1,y] unless x<2 # west unless boundary
    myneighbours << [x,y-1] unless y<2 # north unless boundary
    if diagonal_also # 8-conntected
      neighbours << [x+1,y] unless x >= cols # east unless boundary
      neighbours << [x,y+1] unless y >= rows # south unless boundary
    end
    myneighbours
  end
  
  def neighbours_colors_of(x,y)
    ret = neighbours_of(x,y).map{|el| get(el[0],el[1]) }                    
		deb "neighbour_colors_of = #{ret}"
		ret
  end


=begin
	Fill the region R with the colour C. 
	R is defined as: Pixel (X,Y) belongs to R. 
	Any other pixel which is the same colour as (X,Y) and shares a common side with any pixel in R also belongs to this region.

	From the filling description looks like a 4-connectivity filling (I did on my thesis!).

	This is known in literature as "Connected component labeling" or "4/8-connectivity labelling".

	The solution consistes on Labelling, then filling everything which has the same label as the P(x,y)

	Pass 1:
		Create a matrix of boolean initialiazed to false (or int to 0). I reuse my matrix with true (1) and false (0).
		Create a linked_list
=end
  
  def twopass(data)
    linked_list = Hash.new
    labels = ColorMatrix.new(cols,rows,:background)
    next_label = 1  #  0 is background, we start with 1
    deb "twopass data:\n#{data}"
    
    # First pass
    (1..rows).each do |y|
      (1..cols).each do |x|
	#deb "LinkedList: #{linked_list.inspect}"
        if data.get(x,y) != 0
	  # all neighbours
	  neighbours = labels.neighbours_of(x,y)
	  neighbours_filtered = labels.neighbours_of(x,y).select{|el| # el is an array(x,y) 
	    #deb "EL #{el[0]},#{el[1]} vs #{x},#{y} -- #{el.inspect}"
	    #labels.get(el[0],el[1]) == labels.get(x,y)
	    data.get(el[0],el[1]) == data.get(x,y)
	  }
	  neighbour_labels = labels.neighbours_colors_of(x,y)
	  #	Neighbours are the elements which are connected with the current elements label
	  deb "P=(#{x},#{y}) Neighbours => #{neighbours.inspect}; Labels: #{neighbour_labels.join(', ')} Filtered: #{neighbours_filtered}"

	  # If neighbours are empty
	  if neighbours == []
	    deb "empty neighbours! next_label = #{next_label}"
	     #deb "Linked[next_label] before = #{linked_list[next_label]}" #  << next_label
	    linked_list[next_label] ||= []
	    #assert(linked_list.class == Hash, "LinkedList3 must be an Hash: #{linked_list.inspect}")
	    #assert(next_label.class == Fixnum, "should be a number")
	    #linked_list[next_label] << next_label if next_label
	    #deb "Linked[next_label] after  = #{linked_list[next_label]}" #  << next_label
	    labels.set(x,y,next_label) 
	    #assert(linked_list.class == Hash, "LinkedList1 must be an Hash")
	    #assert(linked_list[next_label].class == Array, "LinkedList[nl] must be an Array: #{linked_list[next_label].inspect}")
	    #(linked_list[next_label]).uniq! # removes from Hash multuiple elements, like a Set
	    #assert(linked_list.class == Hash, "LinkedList2 must be an Hash")
	    next_label = next_label + 1
	  else # not empty			
	    # find the smallest label
	    deb "Not empty! P=(#{x},#{y}) Neighbours => #{neighbours.inspect}; Labels: #{neighbour_labels.join(', ')}"
	    labels.set(x,y,neighbour_labels.min)
	    for label in neighbour_labels do
	      #linked_list[label] ||= []
	      # linked_list[label] << neighbour_labels
	    end
	  #deb "Linked now is: #{linked_list.inspect}"
	  end
	end
      end
    end
		
    # debug print intermedium
    labels.print "First labelling pass" if ColorMatrix.deb?

    # Second pass todo
    (1..rows).each do |y|
      (1..cols).each do |x|
        if data[x][y] != 0
	  labels.set(x,y, _find(labels[x][y]) )
	end
      end
    end
    labels.print "after second pass" if ColorMatrix.deb?

    return labels
  end

  def _find(s)
    s.to_i
  end

  def fill(x,y,color)
    deb "fill(x,y,color)"
		assert(x>=0 && x<cols, "x must be within 0..cols")
    deb "Original matrix: \n#{self}"
    m2 = twopass(self) # applies the two-pass algorithm
    #m2 = onepass(self) # applies the two-pass algorithm
    label_xy = m2.get(x,y)

    deb "Label from my point: #{label_xy}"
    
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
	set(x,y,:white)
      end
    end
  end
  
  def print(description = "This matrix has the following elements")
    deb "[PRINT] #{description}:\n"
    puts self.to_s
  end
  
  # Takes array and splits into chunks of X size
  def to_s
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

  def self.set_debug(b)
    @@debug = b
  end

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

  def assert(assertion, description)
    return if assertion
    puts "ASSERT ERROR: #{description}"
    exit 1
  end

end #/ColorMatrix class
