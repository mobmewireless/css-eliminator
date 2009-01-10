
unless ARGV.length == 3
  puts "Usage: ruby css_intelligent_compressor.rb 
            <input_html_file> <input_css_file> <output_minimized_css_file>
        Input can be any resource, e.g. http://"
  exit 1
end

require 'css_eliminator'
require 'open-uri'

puts "Loading HTML..."
html_doc = open(ARGV[0]).read
puts "Loading CSS..."
css_doc = open(ARGV[1]).read

puts "Generating matching CSS..."
rule_css = CSSEliminator.find_all_css_matching(html_doc, css_doc)

puts "Writing file..."
File.open(ARGV[2], "w") do |f|
  f.write(rule_css)
end

puts "Done!"