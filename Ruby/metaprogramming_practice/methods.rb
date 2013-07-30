#Going over define_method, send, and ghost methods (method_missing)

class Worker
  attr :name

  def initialize(name)
    @name = name
  end

  def self.define_component(method)
    define_method(method) do 
      puts "I'm a method called #{method}"
    end
    undef_method(method)
  end

  def method_missing(method, *args, &block)
    puts "hit method missing"
    puts "And I have a block!" if block_given?
    yield("herrow2") if block_given?
    #yield("herrow2") <= results in error if block given
    if method.match(/_name$/)
      x = method.to_s.gsub("_name","")
      return "#{x}"
    end
    puts "You called #{method} I hit method missing!"
    puts "Args are: "
    args.each {|a| puts a}
  end

  def kyle_name(*output, &block)
    output.each {|o| puts o}
    yield if block_given?
  end

end

if __FILE__ == $0
  kyle = Worker.new("Kyle")
  #Basic method missing practice
  kyle.hero(1,2,3) do |arg|
  end

  #Dynamic dispatch by using send(method, *args, &block)
  #Send allows you to expressly access private methods
  x = "kyle"
  kyle.send("#{x.to_s.downcase}_name", 25, 30) do
    puts "THIS BE THE KYLE"
  end

  #Dynamic instance method defining using Class.define_method
  tommy = Worker.new("Tommy")
  puts tommy.respond_to?("meth")
  Worker.define_component("meth")
  puts tommy.respond_to?("meth")
  tommy.meth
  puts tommy.respond_to?("meth")

  #Method missing fun
  puts tommy.sorry_name
  tommy.tommy_name do |x|
    puts 'HERROW'
    puts x
  end
end
