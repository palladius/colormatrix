

class Person
  
  attr_accessor :name, :surname
  def initialize(name,surname='Smith')
    @name = name
    @surname = surname
  end
  
  def to_s
    "Mr #{name} #{surname}"
  end
  
  
end