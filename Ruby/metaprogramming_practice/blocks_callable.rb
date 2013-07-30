#While most things in ruby are objects, blocks are not. They are callable though.
#So you need to turn them into an object if you want to store them for later
#that's where procs come in
#
#4 Different ways to define a proc:
# => Proc.new
# => proc {|x| ... } => returns from high-level scope, no parameter checking
#     -- in ruby 1.8, Kernelproc = lamda; in ruby 1.9, Kernel#proc = Proc.new(
# => lambda {|x| ... } => returns from local scope, errors with ArgumentError if parameters don't match
# => & sign

def proc_example
  p = proc {|x,y| return x*y }
  result = p.call(2,12) * 5
  return result # => doesn't get executed because proc returns from where it was defined
  #p.call(2,3,4) #=> would not error
end

def lambda_example
  l = lambda {|x,y| return x*y }
  result = l.call(2,12) * 5
  return result # => does get executed because lambda only returns locally
  #p.call(2,3,4) #=> would error with an ArgumentError
end

x = proc_example
puts x

y = lambda_example
puts y

#Passing blocks to different methods with the & character
def first_method(v, &block)
  second_method(&block) * v # => & allows you to pass to other methods
end

def second_method(&block)
  yield(10,10)
end

temp_proc = lambda {|f, g| f * g }
value = first_method(5, &temp_proc)
puts value
