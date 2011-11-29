#!/usr/bin/env ruby

# TODO better inclusion, not tree-dependant :)
require '~/git/colormatrix/color_matrix.rb'

def main
  puts 'Hello from main'
  puts '---------------'
  puts "\n1. Creating matrix"
  matrix = ColorMatrix.new(5,6)
  #p "DEB class=#{matrix.class}"
  
  puts "\n2. Colouring:"
  matrix.L( 2,3,'A' )
  #matrix.colour( 3,2,'B' )
  
  matrix.F 3,3,'J' 
  matrix.V 2,3,4,'W' 
  matrix.H 3,4,2,Z 
  matrix.S
  
  puts "\n3. Printing"
  matrix.S()
end


main