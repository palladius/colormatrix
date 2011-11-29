#!/usr/bin/env ruby

require '~/git/colormatrix/color_matrix.rb'

#include ColorMatrix



def main
  puts 'Hello from main'
  puts '1. Creating matrix'
  #matrix = ColorMatrix.I(5,6)
  matrix = ColorMatrix.initialize(5,6)
  puts "2. Colouring: #{matrix.to_s}"
  p matrix.class
  #matrix.L( 2,3,'A' )
  matrix.colour( 2,3,'A' )
  puts '1. Printing'
  matrix.S()
end


main