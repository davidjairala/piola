# encoding: utf-8

module Piola

  module SpecialChars

    # Determines if a char is a spanish letter
    def spanish_char?
      accents = [193, 201, 205, 209, 211, 218, 220, 225, 233, 237, 241, 243, 250, 252, 246, 214]

      ord = self.ord
      return true if ord == 32
      return true if ord >= 65 && ord <= 90
      return true if ord >= 97 && ord <= 122
      return true if accents.include?(ord)
      false
    end

    # Remove all characters that are not pure letters
    def only_letters
      str = self
      str = str.gsub(',', ' ')
      str = str.gsub('.', ' ')
      str = str.gsub(/ +/, ' ')
      str = str.strip

      str = str.split('').map do |char|
        char if char.spanish_char?
      end.compact.join

      str = str.gsub(/ +/, ' ').strip
      str
    end

    # Converts special chars to downcase
    def downcase_special_chars
      str = self
      str = str.gsub("Á", "á")
      str = str.gsub("É", "é")
      str = str.gsub("Í", "í")
      str = str.gsub("Ó", "ó")
      str = str.gsub("Ú", "ú")
      str = str.gsub("Ñ", "ñ")
      str = str.gsub("Ü", "ü")
      str
    end

    # Remove spanish special chars
    def remove_special_chars
      str = self
      str = str.gsub("Á", "A")
      str = str.gsub("É", "E")
      str = str.gsub("Í", "I")
      str = str.gsub("Ó", "O")
      str = str.gsub("Ú", "U")
      str = str.gsub("Ñ", "N")
      str = str.gsub("Ü", "U")

      str = str.gsub("á", "a")
      str = str.gsub("é", "e")
      str = str.gsub("í", "i")
      str = str.gsub("ó", "o")
      str = str.gsub("ú", "u")
      str = str.gsub("ñ", "n")
      str = str.gsub("ü", "u")
      str
    end

    # Clean text
    def clean_text(remove_parens = true)
      str = self
      str = str.html_decode
      str = str.remove_all_parenthesis if remove_parens
      str = str.gsub(/\n|\t/, ' ').gsub(/ +/, ' ')
      str = str.strip
      str
    end

    # Get rid of all weird stuff for urls
    def clean_url
      str = self
      str = str.remove_enters
      str = str.remove_tabs
      str
    end

    # Remove tabs
    def remove_tabs
      str = self
      str = str.gsub(/\t/, "")
      str = str.gsub(/ +/, ' ')
      str = str.strip
      str
    end

  end

end

String.send :include, Piola::SpecialChars