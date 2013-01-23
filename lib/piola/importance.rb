module Piola

  module Importance

    # Counts words in a string
    def count_words
      str = self
      str = str.gsub(/( )+/, ' ')
      str = str.strip
      str = str.split(" ")
      str.length
    end

    # Get most important parragraph from a text
    def longest_parragraph
      parragraphs = self.split("\n")
      longest_p = ''

      parragraphs.each do |p|
        p = p.strip

        if p.length >= longest_p.length
          longest_p = p
        end
      end

      longest_p
    end

    # Important words from a string
    def important_words
      str = self
      str = str.gsub(/ +/, ' ').strip
      parts = str.split(' ')
      parts.reject { |p| p.length <= 3 }.join(' ')
    end

    # Return just the most important clean words of a string
    def just_words(options = {})
      str = self
      str = str.
              clean_text.
              remove_quotes.
              strip_tags.
              remove_all_parenthesis.
              downcase

      str = str.important_words       unless options[:small_words]
      str = str.remove_special_chars  unless options[:leave_special]
      str = str.only_letters
      str
    end

  end

end

String.send :include, Piola::Importance