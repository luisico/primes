#!/usr/bin/env ruby

require 'optparse'
require_relative '../lib/prime'

# Default options
options = {
  max_primes: 10,
  cell_width: 5
}

# Parse command line options
OptionParser.new do |opts|
  opts.on('-m', '--max INTEGER',   Integer, 'Maximum prime numbers') { |arg| options[:max_primes] = arg }
  opts.on('-w', '--width INTEGER', Integer, 'Cell width')            { |arg| arg.inspect; options[:cell_width] = arg }
  opts.parse!(ARGV)
end

# Find max_primes numbers
number = 2
while Prime.primes.size < options[:max_primes]
  Prime.new number
  number = number + 1
end

# Multiplication table
vertical_separator = '| '

# Column headers
printf "%-#{options[:cell_width]}s%-#{vertical_separator.size}s", '', vertical_separator
Prime.primes.each { |col| printf "%-#{options[:cell_width]}d", col }
puts ''

# Horizontal separator
((Prime.primes.size + 1) * options[:cell_width] + vertical_separator.size).times{|i| print '-'}
puts ''

# Rows
Prime.primes.each do |row|
  # First column
  printf "%-#{options[:cell_width]}d%-#{vertical_separator.size}s", row, vertical_separator

  # Data cells
  Prime.primes.each do |col|
    printf "%-#{options[:cell_width]}d", row*col
  end
  puts ''
end
