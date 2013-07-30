#A standard module only houses instance methods that are accessible to objects
#and not classes. So it's easy to make a 'mix-in' if you only need extra instance
#methods. But what if you want to make a 'mix-in' with class methods?
#
#You need to edit the included hook (which hits when the module is 'included'),
#and edit the base class to 'extend' another module of methods. Extend creates
#singleton methods for a given object. This 'extend' will give the base class
#access to these singleton methods, which is exactly what a class method is - a singleton method!
module Test # => only houses instance methods, unless you do...

  #Hook
  def self.included(base) # => this is a hook that is hit when the module is included
    #Class Extensions
    #Since class methods are always singleton methods...
    base.extend(ClassMethods) # => Only way to include Class methods in a module
  end

  module ClassMethods
    def run_away
      puts "This is the ClassMethods module that I extended!"
    end
  end

  def self.run_away # => this is only a class(singleton) method of module Test, not for the included class
    puts "This is the Test module"
  end

  #But for instances of the base class, you just use the module regularly since they're not singleton
  def catch
    puts "This is an instance method"
  end
end

class Person
  include Test
end

Test.run_away           # => "This is a the Test module"
Person.run_away         # => "This is the ClassMethods module that I extended!"
catcher = Person.new
catcher.catch           # => "This is an instance method"
