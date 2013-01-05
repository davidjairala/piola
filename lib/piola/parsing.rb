require 'active_support/core_ext/object/blank'

module Piola

  module Parsing

    # Remove all parenthesis types
    def remove_all_parenthesis(strip = true)
      str = self
      str = str.gsub(/\[.*\]/, "")
      str = str.gsub(/\(.*\)/, '')
      str = str.gsub(/\{.*\}/, '')
      str = str.strip if strip
      str = str.gsub(/ +/, ' ')
      str
    end

    # Remove enters
    def remove_enters
      str = self
      str = str.gsub("\n", " ")
      str = str.gsub("\r", " ")
      str = str.gsub(10.chr, " ")
      str = str.gsub(13.chr, " ")
      str = str.gsub("<br />", " ")
      str = str.gsub("<br>", " ")
      str = str.gsub("<br/>", " ")
      str = str.gsub("<BR />", " ")
      str = str.gsub("<BR>", " ")
      str = str.gsub("<BR/>", " ")
      str = str.gsub(/( )+/, ' ')
      str = str.strip
      str
    end

    # Removes extra enters
    def remove_extra_enters
      self.split("\n").map do |p|
        p.strip if p.present?
      end.compact.join("\n")
    end

    # Remove quotes
    def remove_quotes
      str = self
      str = str.gsub('"', '')
      str = str.gsub("'", '')
      str
    end

  end

end

String.send :include, Piola::Parsing