module DocScan
  Scanner = Struct.new(:path, :valid_extensions, :words_to_cleanup, :tags_to_cleanup)

  class Scanner

    def initialize(*args, &block)
      super
      yield self if block_given?
    end

    def name_cleaner
      @name_cleaner ||= NameCleaner.new(words_to_cleanup)
    end

    def paths
      Dir[File.join(path, "**", "*")].select {|p| File.file?(p) }.select { |path| path =~ extensions_regexp }
    end

    def scan(clear = false)
      @results = nil if clear
      @results ||= scan!
    end

    def scan!
      paths.map { |path| Document.new(self, path, name_cleaner) }
    end

    def each(&block)
      scan && @results.each(&block)
    end

    def extensions_regexp
      @extensions_regexp ||= valid_extensions ? /#{valid_extensions.join("|")}$/i : //
    end
    private :extensions_regexp
  end
end
