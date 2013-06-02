module Piola

  module Html

    # Remove html tags
    def strip_tags
      str = self
      str = str.gsub(/<\/?[^>]*>/, '')
      str = str.gsub(/&lt;.*?&gt;/, '')
      str = str.gsub('&raquo;', '')
      str = str.gsub('&nbsp;', ' ')
      str = str.remove_all_parenthesis
      str
    end

    # Remove html tags but leaves enters instead of tags
    def strip_tags_enters(remove_parens = true)
      str = self
      str = str.gsub(/<\/?[^>]*>/, "\n").gsub('&raquo;', '').gsub('&nbsp;', ' ')

      str = str.split("\n").map do |parragraph|
        parragraph.strip
      end.compact.join("\n")

      str = str.remove_all_parenthesis(false) if remove_parens
      str
    end

    # chars to html
    def html_encode
      require 'htmlentities'

      coder = HTMLEntities.new
      coder.encode(self, :named)
    end

    # html to chars
    def html_decode
      require 'htmlentities'

      str = self

      coder = HTMLEntities.new
      return coder.decode(str)
    rescue ArgumentError => e
      if e.message == 'invalid byte sequence in UTF-8'
        str = str.encode( 'UTF-8', 'Windows-1252' )

        return coder.decode(str)
      else
        raise e
      end
    end

    # Determines if a string might be an html/style/js leftover
    def html_leftover?
      [
        /\/\*/,
        /\*\//,
        '{',
        '}',
        /document\./i,
        /text\/javascript/i,
        /this_options/i,
        /socialwrap/i,
        /followwrap/i,
        /addtoany_list/i,
        /addto/i,
        /akocomment/i,
        /imagetransform/i,
        /warning\: mysql/i,
        /error\: mysql/i,
        '<',
        '>'
      ].each do |suspect|
        return true if self.match(suspect)
      end
      false
    end

  end

end

String.send :include, Piola::Html