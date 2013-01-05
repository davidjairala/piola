module Piola

  module Encoding

    def to_iso
      self.force_encoding('ISO-8859-1')
    end

    def to_utf8
      self.force_encoding('UTF-8')
    end

    def utf8?
      begin
        self.encoding.name == 'UTF-8'
      rescue ArgumentError => e
        return false if e.message == 'invalid byte sequence in UTF-8'
      rescue Encoding::CompatibilityError
        return false
      end
    end

    def iso?
      begin
        self.encoding.name == 'ISO-8859-1'
      rescue ArgumentError => e
        return false if e.message == 'invalid byte sequence in ISO-8859-1'
      rescue Encoding::CompatibilityError
        return false
      end
    end

  end

end

String.send :include, Piola::Encoding