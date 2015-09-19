require 'benchmark/ips'

in_array = %w(ruby and irb rocks rails too)
in_hash = {}
in_array.each { |el| in_hash[el] = true }

Benchmark.ips do |x|
  x.report('include?') { in_array.include? 'rocks' }
  x.report('key?') { in_hash.key? 'rocks' }
  # Compare!
  x.compare!
end
