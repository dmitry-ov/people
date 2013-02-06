m,w = {},{}
 
a.each {|key, value| 
  puts "#{key} => #{value}"
  m.merge!(key => value) unless key.index('m').nil?
  w.merge!(key => value) unless key.index('w').nil? 
}

puts m

puts w


def pic(i)
  if (1..100).include?(i)  
    i.times{ putc "#" }
    puts
  end  
end


m.each{ |key, value|  
   puts key.to_s + "  "
   pic(value.to_i)
}

