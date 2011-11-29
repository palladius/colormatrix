#!/usr/bin/env ruby

require '~/git/colormatrix/color_matrix.rb'
require '~/git/colormatrix/person.rb'

def main
  puts 'Hello from main'
  puts '---------------'
  puts "\n1. Creating matrix"
  matrix = ColorMatrix.new(5,6)
  p "DEB class=#{matrix.class}"
  
  puts "\n2. Colouring: #{matrix.to_s}"
  #matrix.L( 2,3,'A' )
  matrix.colour( 2,3,'A' )
  
  puts "\n3. Printing"
  matrix.S()
end


main