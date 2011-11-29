#!/usr/bin/env ruby

require '~/git/colormatrix/color_matrix.rb'




def main
  puts 'Hello'
  matrix = new ColorMatrix(10,20)
  matrix.I 5,6
  matrix.L 2,3,'A'
  matrix.S
end


main