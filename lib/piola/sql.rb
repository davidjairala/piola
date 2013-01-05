require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/array/extract_options'

module Piola

  module Sql

    # Converts a string to a sql search string
    def sql_search(fields)
      str = self
      str = str.gsub("'", '')
      str = str.gsub('"', '')
      str = str.gsub("\\", '')
      str = str.gsub("%", '')
      str = str.gsub("/", ' ')
      str = str.gsub(":", ' ')
      str = str.gsub("=", ' ')
      str = str.gsub("?", ' ')

      if str.strip.present?
        arr   = str.to_arr
        rows  = []
        cells = []

        fields.each do |field|
          cells = []

          arr.each do |a|
            cells << "(#{field} LIKE \"%#{a}%\")"
          end

          rows << "(" + cells.join(" AND ") + ")"
        end

        return rows.join(" OR ")
      else
        return '0'
      end
    end

    # Converts a string to a sql search query
    def searchify(*args)
      fields  = args.first
      options = args.extract_options!

      operator = options[:operator] || :and
      operator = operator.to_s.upcase

      str = self
      str = str.gsub(/ +/, ' ')
      str = str.gsub("'", '')
      str = str.gsub("\\", '')
      str = str.gsub("%", '')
      str = str.gsub("/", ' ')
      str = str.gsub(":", ' ')
      str = str.gsub("=", ' ')
      str = str.gsub("?", ' ')
      str = str.strip

      if str.present?
        exacts          = []
        regulars        = []
        exact_excludes  = []
        excludes        = []

        # Check for exact excludes
        exact_excludes_matches = str.scan(/-"(.*?)"/)

        exact_excludes_matches.each do |match|
          match = match.first

          # Remove match from main string
          str = str.gsub(/-"#{match}"/, '').strip

          exact_excludes << match.strip
        end

        # Check for exact searches
        exact_matches = str.scan(/"(.*?)"/)

        exact_matches.each do |match|
          match = match.first

          # Remove match from main string
          str = str.gsub(/"#{match}"/, '').strip

          exacts << match.strip
        end

        # Check for excludes with spaces after them
        exclude_matches = str.scan(/-.+? /)

        exclude_matches.each do |match|
          match.strip!
          match = match.gsub(/-/, '')

          # Remove match from main string
          str = str.gsub(/-#{match}/, '').strip

          excludes << match.strip
        end

        # Check for excludes at the end of the string
        exclude_matches = str.scan(/-.+?$/)

        exclude_matches.each do |match|
          match.strip!
          match = match.gsub(/-/, '')

          # Remove match from main string
          str = str.gsub(/-#{match}/, '').strip

          excludes << match.strip
        end

        # Check for regular searches
        regulars = str.to_arr

        # Build the query
        query   = []
        rows    = []
        cells   = []

        # Includes
        query_includes = ""

        if exacts.any? || regulars.any?
          fields.each do |field|
            cells = []

            [exacts, regulars].each do |matchers|
              matchers.each do |matcher|
                cells << "#{field} LIKE \"%#{matcher.remove_quotes}%\""
              end
            end

            rows << cells.join(" #{operator} ")
          end

          query_includes = rows.join(" OR ")
          query << "(#{query_includes})"
        end

        # Excludes
        query_excludes = ""

        if exact_excludes.any? || excludes.any?
          rows  = []
          cells = []

          fields.each do |field|
            cells = []

            [exact_excludes, excludes].each do |matchers|
              matchers.each do |matcher|
                cells << "#{field} NOT LIKE \"%#{matcher.remove_quotes}%\""
              end
            end

            rows << cells.join(" #{operator} ")
          end

          query_excludes = rows.join(" AND ")
          query << "(#{query_excludes})"
        end

        return query.join(" AND ") if query.any?
        return '0'
      else
        return '0'
      end
    end

  end

end

String.send :include, Piola::Sql