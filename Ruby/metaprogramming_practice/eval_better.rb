#This is much better because we're not messing with any regular evals, and it's
#a much cleaner way to code dynamic methods

def eval_string(klass, attrib)
  klass.class_eval do # => Dynamic class changing (changing 'self')
    define_method attrib do # => Dynamic method creation
      instance_variable_get("@#{attrib}") # => Dynamic variable retrieval
    end

    define_method "#{attrib}=" do |value|
      instance_variable_set("@#{attrib}", value) # => Dynamic variable setting
    end
  end
end

eval_string(String, "poop")
x = String.new
x.poop = "5"
puts x.poop

#much better than eval.rb
