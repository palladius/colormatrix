#!/usr/bin/env ruby

=begin

	This class just calls the sample ColorMatrix class
	as a proof of concept. The parsing can be done in a second time 

=end

require 'color_matrix.rb'

def main
  matrix = ColorMatrix.new(5,6)
  matrix.L(2,3,'A')
  matrix.F(3,3,'J')
  matrix.V(2,3,4,'W') 
  matrix.H(3,4,2,'Z')
  matrix.S()
end

main()
