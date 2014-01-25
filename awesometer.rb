# This program consists of a class used to determine
# various awesomeness values from an input Array.
#
# A Person object is also provided to be used as the
# contents of the Array
#
# Author::    Dave Obrite (mailto: davidobrite@gmail.com)
# License::   Public Domain

# This class is used to identify the most awesome person,
# the average awesomeness, and can print out the top
# 10 most awesome people from an Array of objects passed.
class Awesometer

  # Initializes an Awesometer with an Array
  def initialize awesomes
    raise TypeError if !awesomes.is_a?(Array)
    @awesomes = awesomes
  end

  # returns most awesome person in array,
  # defaults to first person if a tie
  # returns nil for an empty Array
  def most
    @awesomes.max
  end

  # returns the average awesomeness of the array
  def avg
    raise NotDefinedError if @awesomes.size == 0
    sum = @awesomes.reduce(0.0) do |sum, person|
      sum + person
    end
    sum / @awesomes.size
  end

  # prints the top ten most awesome people
  def top_ten
    puts @awesomes.sort.reverse.first(10)
  end

end

# Our Person Struct representing a single person
class Person < Struct.new(:name, :awesomeness)
  include Comparable

  # Initializes Person
  def initialize(name, awesomeness)
    raise TypeError if !name.is_a?(String)
    raise TypeError if !awesomeness.is_a?(Integer)
    @name, @awesomeness = name, awesomeness
  end

  def +(other_person)
    @awesomeness + other_person.awesomeness
  end

  def <=>(other_person)
    @awesomeness <=> other_person.awesomeness
  end

  def to_s
      name + " AR: " + awesomeness.to_s
  end
end

# Error for the average of an empty Array
class NotDefinedError < StandardError; end
