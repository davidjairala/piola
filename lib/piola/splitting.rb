require 'active_support/core_ext/object/blank'

module Piola

  module Splitting

    # Converts a string into a word array without extra spaces, etc
    def to_arr(options = {unique: true})
      str = self
      str = str.strip
      str = str.gsub(',', ' ')
      str = str.gsub('.', ' ')
      str = str.gsub(/ +/, ' ')
      arr = str.split(' ')
      arr = arr.compact
      arr = arr.uniq if options[:unique]
      arr
    end

    # Converts a string into a parragraph array
    def string_to_parragraph_arr
      str = self
      str = str.strip
      str = str.gsub(',', ' ')
      str = str.gsub('.', ' ')
      str = str.gsub(/ +/, ' ')
      str = str.strip
      str = str.gsub("\r", "\n")
      arr = str.split("\n")
      
      arr.map do |part|
        part.strip if part.strip.present?
      end.compact
    end

    # Converts a string into a parragaph array with only important sentences
    def string_to_important_parragraph_arr
      arr = self.string_to_parragraph_arr

      arr.map do |part|
        part if part.count_words >= 5 && !part.html_leftover?
      end.compact.uniq
    end

  end

end

String.send :include, Piola::Splitting