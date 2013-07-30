#eval() is a very powerful tool because you can write whatever code you need
#to, even if it only accepts constants. E.g.

def eval_string(klass, attrib)
  s = <<EOS
  class #{klass}
    def #{attrib}
      @#{attrib}
    end

    def #{attrib}=(value)
      @#{attrib} = value
    end
  end
EOS
  return s
end

eval(eval_string(String, "poop"))
x = String.new
x.poop = "5"
puts x.poop

#Not very clean, is it? Powerful, but dangerous
