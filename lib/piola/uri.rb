module Piola

  module Uri

    def uri_escape
      require 'uri'

      str = URI.escape(self)

      return str
    end

    def uri_unescape
      require 'uri'

      str = URI.unescape(self)

      return str
    end

  end

end

String.send :include, Piola::Uri