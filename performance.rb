# frozen_string_literal: true

require 'benchmark'
require './lib/obfuscate_morse'
n = 5000
MESSAGE = 'I AM IN TROUBLE'
Benchmark.bm(7) do |x|
  x.report('morse:') { n.times { morse(MESSAGE) } }
  x.report('obfuscate morse:') { n.times { obfuscated_morse(MESSAGE) } }
end
