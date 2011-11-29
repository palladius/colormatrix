#!/usr/bin/env ruby

require '~/git/colormatrix/color_matrix.rb'
require '~/git/colormatrix/person.rb'

def main
  puts 'Hello from main'
  pers = Person.new('Riccardo')
  p pers.to_s
  puts '1. Creating matrix'
  #matrix = ColorMatrix.I(5,6)
  matrix = ColorMatrix.INIT(5,6)
  puts "2. Colouring: #{matrix.to_s}"
  p matrix.class
  #matrix.L( 2,3,'A' )
  matrix.colour( 2,3,'A' )
  puts '1. Printing'
  matrix.S()
end


main