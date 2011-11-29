
class Pixel
  attr_accessor :x,:y

	def	initialize(x,y)
		@x = x
		@y = y
	end

	#def [](y)
	#	@ary[y]
	#end
	def to_s
		"Pixel(#{x};#{y})"
	end
end
 
