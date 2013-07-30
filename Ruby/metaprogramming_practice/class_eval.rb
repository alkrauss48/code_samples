#Use class_eval (or module_eval) when you need to access a class and you
#don't always know the name of the class (e.g. it's a var).
#
#"class" can only take a constant, class_eval can take a var
#
#use instance_eval if you don't need to open a class. If it's both an object
#and a class, then they both function similarly

def modify_class(klass)
  klass.class_eval do
    def m
      puts "I am a new method!"
    end
  end
end

p = String.new
modify_class(String)
p.m

#class level instance variables(@) can't accessed in instance methods, but
#class level (@@) variables can be
class Example
  @@var = 5 # => Accessible in instance methods; has class-level scope
  @my_var = 2 # => not accessible in instance methods; has local scope
  def self.read; @my_var; end # => refers to class @my_var 2
  def write; @myvar = 1; end
  def read; @myvar; end # => refers to instance @my_var = 1
  
  def nil_protector
    @non_defined_var || String
  end
end

e = Example.new
e.write
puts e.read
puts Example.read

puts e.nil_protector # => String, since @non_defined_var isn't defined
e.instance_eval {@non_defined_var = "I exist!"}
puts e.nil_protector
