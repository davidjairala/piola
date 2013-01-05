module Piola

  module Numbers

    # Checks if string is a valid number
    def valid_number?
      !!self.match(/^-?[\d]+(\.[\d]+){0,1}$/)
    end

    # Removes numbers parragraphs from a text
    def remove_numbers
      self.split("\n").map do |parragraph|
        parragraph unless parragraph.strip.valid_number?
      end.compact.join("\n")
    end

  end

end

String.send :include, Piola::Numbers