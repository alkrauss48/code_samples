#singleton methods are used to define a method only for a specific object
#This is useful if you want to override a method for a particular
#variable, but not for all other vars of the same class
#
#NOTE: Class methods (self.method) are all singleton methods, because all classes
#themselves have a class of CLASS. Therefore, e.g. if you do this:
#
#class String
#  def self.hello
#    puts "hello"
#  end
#end
#
#You are declaring that method ONLY for class String (which is self - an object
#of Class), and not for all classes in class Class. This further means that
#all class methods of String are stored in String's eigenclass!

paragraph = "this is a paragraph"
str = "random string"

def paragraph.upcase # => only affects paragraph
  self.capitalize
end

puts paragraph.upcase
puts str.upcase

#This is an example of a class method, which are always singleton
#methods, since only that class can call it
class Example
  def self.test
    puts "this is a test"
  end
end

Example.test # => singleton method call and a class method call
