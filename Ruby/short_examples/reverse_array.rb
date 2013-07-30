# Aaron Krauss - Question 3
# Estimated time: 8 min
# No sources used
# Command to run: ruby ques_3.rb

class ReverseArray

  attr_accessor :old, :new

  def initialize(array)
    @old = array
    @new = []
  end

  def reverse
    count = 1
    @old.each do |value|
      @new[@old.length - count] = value
      count += 1
    end
    @new
  end

end

array = ReverseArray.new(["This", "Should", "Be", "Backwards"])
puts array.reverse

int_array = ReverseArray.new([1, 2, 3, 5, 8, 13, 21])
puts int_array.reverse
