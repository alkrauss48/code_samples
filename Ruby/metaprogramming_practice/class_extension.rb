#Review: an Eigenclass is the class that houses a unique object's singleton methods
#An eigenclass directly inherits from its object
#"Eigen" means "one's own", meaning it's a class dedicated for a single object
#This example is about grabbing methods from another class or module, and making
#them singleton methods for a single object
module MyMod
  def my_method
    puts "You hit the method!"
  end
end

obj = Object.new

class << obj # => eigenclass of obj, so it has all of obj's singleton methods
  include MyMod # => this makes all of MyMod's instance methods singlegton methods for obj
end

obj.my_method

#This also works - much more cleanly
obj2 = Object.new
obj2.extend(MyMod) # => "extends" the module into the object's eigenclass
obj2.my_method
