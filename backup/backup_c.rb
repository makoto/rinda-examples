require 'drb'

new_a = DRbObject.new_with_uri("druby://makoto-inoues-macbook-pro.local:12345")

new_b = new_a.dup #  => [1, 2, 3, 4, 5, 6] 
new_b.class # => DRb::DRbObject

Marshal.dump new_b # => "\x04\bu:\x13DRb::DRbObject?\x04\b[\aI\"2druby://makoto-inoues-macbook-pro.local:12345\x06:\x06EF0" 

new_a.instance_eval do
  class << self
   undef_method :dup 
  end
end
new_c = new_a.dup
new_c.class

Marshal.dump new_c # => "\x04\b[\vi\x06i\ai\bi\ti\ni\v"


File.open('test.dump', 'w') {|f| Marshal.dump new_c, f}
new_d = File.open('test.dump') {|f| Marshal.load(f)}


File.open('test_msgpack.dump', 'w'){|f| f.puts 1000000.times.to_a.to_msgpack}
