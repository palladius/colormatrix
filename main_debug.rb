#!/usr/bin/env ruby

=begin

	This class just calls the sample ColorMatrix class
	as a proof of concept. The parsing can be done in a second time 

=end

# TODO better inclusion, not tree-dependant :)
require '~/git/colormatrix/color_matrix.rb'

def main
  puts "\n1. Creating matrix"
  matrix = ColorMatrix.new(5,6)
  puts "\n2. Colouring:"
  matrix.L( 2,3,'A')
  puts "\n3. Filling:"
  matrix.V(2,1,6,'W') 
  #matrix.H(3,4,2,'Z')
  #matrix.V(5,2,4,'S') 
  #matrix.H(3,4,5,'N')
  matrix.F(3,3,'f')
  #matrix.F(3,4,'i')
  #matrix.F(1,2,'o')
  puts "\n3. Printing"
  # To test the filling:
  matrix.S()
  #sleep 1
end

main()
