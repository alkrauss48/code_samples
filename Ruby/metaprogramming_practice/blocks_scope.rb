#Using blocks to get by scope constraints
#Scope gates = Modules, Classes, and Methods
#Replacing Scope gates with methods, which creates Flat Scopes

var = "variable"
klass = Class.new do
  @@name = var
  #define_method :"#{klass.downcase}_name" do 
    #puts "Hello, my name is #{klass}"
  #end
  define_method :"class_name" do 
    puts "Hello, my name is #{var}"
  end
end

l = klass.new
l.class_name

#Using "shared scope" to allow only specific methods to have access to a var
def define_methods
  count = 0
  Kernel.send(:define_method, :list) do 
    count
  end
  Kernel.send(:define_method, :inc) do 
    count += 5
  end
end

define_methods
puts list
inc
puts list
