
require 'css_eliminator'
require 'open-uri'

# 
# css_doc = "
# a { color: red } 
# h2 { color: orange }
# div.blue a:hover { color: blue; background: white url(file.jpg); font-family: Arial, Helivetica, sans-serif }
# "
# 
# html_doc = '
# <div class="blue red">
# <h1>Hello World</h1>
# <h1>Hello World</h1>
# <h1>Hello World</h1>
# <h1>Hello World</h1>
# <h1>Hello World</h1>
# <h1>Hello World</h1>
# <h1>Hello World</h1>
# <a href="hello">Hello</a>
# </div>
# '
#

html_doc = open('./examples/mobshare-home.html').read
css_doc = open('./examples/mobshare-full.css').read


puts "Finding matching rules..."
rule_css = CSSEliminator.find_all_css_matching(html_doc, css_doc)

p rule_css