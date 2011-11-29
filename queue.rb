
# Rosetta code, found here
# from http://rosettacode.org/wiki/Bitmap/Flood_fill#Ruby
#
#
#
class Queue < Array
	alias_method :enqueue, :push
	alias_method :dequeue, :shift
end

