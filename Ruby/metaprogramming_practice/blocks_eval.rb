#Breaking the bonds of 'private' data with eval

class Klass
  def initialize
    @v = 1
  end
end

obj = Klass.new

#Even though @v is private and doesn't have any accessors or mutators,
#you can edit and retrieve private variables through instance_eval
#The block is called a 'Context Probe'
#Use 'instance_exec' to pass args to the block
x = 2
obj.instance_eval {@v = x}
puts obj.instance_eval {@v}
