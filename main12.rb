#!/usr/bin/env ruby

=begin

	This class just calls the sample ColorMatrix class
	as a proof of concept. The parsing can be done in a second time 

=end

# TODO better inclusion, not tree-dependant :)
require '~/git/colormatrix/color_matrix.rb'

def main
  puts "\n1. Creating matrix"
  matrix = ColorMatrix.new(2,3)
  puts "\n2. Colouring:"
  matrix.L( 1,2,'A')
  puts "\n3. Filling:"
  matrix.V(2,1,3,'a') 
  matrix.F(2,3,'f')
  puts "\n3. Printing"
  matrix.S()
end

main()
