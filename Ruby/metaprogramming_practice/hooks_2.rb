#Or if you wanted a whole module to be solely dedicated to class methods,
#you could do this:

module MyMod
  def self.included(base)
    # Extending the module's methods as singletons for the
    # base class, therefore making them class methods
    base.extend(self)

    #However, 'include' is a private method of the base class, so in order to
    #access it to add instance methods, you need to use the send method which
    #allows you to call private methods
    #base.include(InstanceMethods) # => won't work
    base.send(:include, InstanceMethods) # => Dynamic Dispatch
  end

  def toodles
    puts "Toodles!"
  end

  module InstanceMethods
    def hello
      puts "hello"
    end
  end
end

class Person
  include MyMod
end

Person.toodles # => "Toodles!"
p = Person.new
p.hello
