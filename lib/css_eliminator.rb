
require 'rubygems'
require 'hpricot'

class CSSEliminator
  class << self
    def find_all_css_matching(html_doc, css_doc)
      html_doc = Hpricot.parse(html_doc)
      selectors = self.find_selectors_from_css(css_doc)
      rules_css = []
      selectors.each do |selector|
        selector_without_pseudo_classes = selector.gsub(/\:(.*)/, '')
        unless (html_doc/selector_without_pseudo_classes).empty? 
          rule_for_selector = self.find_rule_for_selector(selector, css_doc)
          rules_css << rule_for_selector
          p rule_for_selector
        end
      end
      rules_css.uniq.join("\n")
    end

    def find_selectors_from_css(css_doc)
      css_doc = self.normalize_css(css_doc)
      rules = css_doc.split('}').map { |rule| rule << "}" }[0..-2]
      selectors = []
      rules.each do |rule|
        selectors << (rule.match(/(.*)\{(.*)?\}/))[1]
      end
      selectors.uniq
    end

    def find_rule_for_selector(selector, css_doc)
      css_doc = self.normalize_css(css_doc)
      css_doc.match(/^#{selector}\{(.*)?\}/)[0]
    end
    
    def normalize_css(css_doc)
      css_doc.split('}').map { |rule| rule << "}" }[0..-2].join("\n")
    end
  end
end
  