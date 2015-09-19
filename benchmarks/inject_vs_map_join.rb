require 'benchmark/ips'

messages = Array.new(5, 'item')
messages_for_map = messages.dup

Benchmark.ips do |x|
  x.report('inject') { messages.inject('') { |a, e| "#{a}<li>#{e}</li>" } }
  x.report('map/join') { messages_for_map.map { |msg| "<li>#{msg}</li>" }.join }
  # Compare!
  x.compare!
end
