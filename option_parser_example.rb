require "optparse"

puts "ARGV is #{ARGV.inspect}"

params = {}

parser = OptionParser.new

parser.on("-n") {params[:line_numbering_style] ||= :all_lines }
parser.on("-b") {params[:line_numbering_style] = :significant_lines }
parser.on("-s") {params[:squeeze_extra_newlines] = true }

files = parser.parse(ARGV)

puts "params are #{params.inspect}"
puts "files are #{files.inspect}"