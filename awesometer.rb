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
  def initialize(awesomes, output = $stdout)
    raise TypeError if !awesomes.is_a?(Array)
    @awesomes, @output = awesomes, output
  end

  # returns most awesome person in array,
  # delegates to Array.max which
  # defaults to first person if a tie and
  # returns nil for an empty Array
  def most
    @awesomes.max
  end

  # returns the average awesomeness of the array
  def avg
    raise NotDefinedError if @awesomes.size == 0
    @awesomes.reduce(:+) / @awesomes.size.to_f
  end

  # prints the top ten most awesome people
  def top_ten
    @output.puts @awesomes.sort.reverse.first(10)
  end

end

# Our Person Object
class Person
  include Comparable
  attr_reader :name, :awesomeness

  # Initializes Person
  def initialize(name, awesomeness)
    raise TypeError if !name.is_a?(String)
    raise TypeError if !awesomeness.is_a?(Integer)
    @name, @awesomeness = name, awesomeness
  end

  # allows FixNum + Person
  def coerce(other)
    [Person.new("", other), self]
  end

  # override addition to use awesomeness
  def +(other_person)
    @awesomeness + other_person.awesomeness
  end

  # defined spaceship for ordering
  def <=>(other_person)
    @awesomeness <=> other_person.awesomeness
  end

  # pretty(ish) print
  def to_s
    @name + " AR: " + @awesomeness.to_s
  end
end

# Error for the average of an empty Array
class NotDefinedError < StandardError; end
