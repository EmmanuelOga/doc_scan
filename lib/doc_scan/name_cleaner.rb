module DocScan
  NameCleaner = Struct.new(:keywords)

  class NameCleaner
    def clean(name)
      name.downcase!
      clear_non_sentence_chars!(name)
      clear_keywords!(name)
      titleize!(name)
      strip_char!(name, "-")
      normalize_spaces!(name)
      name
    end

  private

    def regexp_to_cleanup
      @regexp_to_cleanup ||= /\b#{keywords.join("|")}\b/ if keywords
    end

    def clear_non_sentence_chars!(string)
      string.gsub!(/[\._,'"\)\(\[\]]/, " ")
      string
    end

    def clear_keywords!(string)
      string.gsub!(regexp_to_cleanup, " ") if regexp_to_cleanup
      string
    end

    def titleize!(string)
      string.gsub!(/\b('?[a-z])/) { $1.capitalize }
      string
    end

    def strip_char!(string, char)
      string.gsub!(/^\s*#{char}+|#{char}+\s*$/, "")
      string
    end

    def normalize_spaces!(string)
      string.squeeze!("-")
      string.squeeze!(" ")
      string.strip!
      string
    end
  end
end
