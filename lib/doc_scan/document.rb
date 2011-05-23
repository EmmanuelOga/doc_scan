module DocScan
  Document = Struct.new(:scanner, :path, :name_cleaner)

  class Document
    private :scanner=, :path=, :name_cleaner=

    def basename
      File.basename(path)
    end

    def dirname
      File.dirname(path)
    end

    def ext
      File.extname(path)
    end

    def clean_path
      @clean_path ||= clean_path!
    end

    def clean_path!
      b = gdata.title rescue nil
      b = clean_name if b.nil? || b !~ /\S/
      "#{b}#{ext}"
    end

    def name
      basename[0, basename.length - ext.length]
    end

    def clean_name
      @clean_name ||= name_cleaner.clean(name)
    end

    def checksum
      @adler32 ||= Zlib.adler32(File.read(path))
    end

    def inferred_isbn
      @inferred_isbn ||= RISBN::Scanner.scan(path)
    end

    def inferred_tags
      @inferred_tags ||= inferred_tags!
    end

    def inferred_tags!
      tags = dirname.to_s.downcase.split("/")[prefix_directories..-1].sort
      tags -= scanner.tags_to_cleanup if scanner.tags_to_cleanup
      tags
    end
    private :inferred_tags!

    def gdata
      @gdata ||= RISBN::GData(inferred_isbn.to_s).data if inferred_isbn.to_s =~ /\S/
    rescue
      # do nothing, google data for this document won't be available.
    end

    def prefix_directories
      @prefix_directories ||= scanner.path.split("/").length
    end

    def to_s
      inferred_tags.empty? ? clean_name : "#{clean_name} (#{inferred_tags.join(", ")})"
    end

    def to_hash
      {
        :checksum => checksum.to_s,
        :isbn     => inferred_isbn.to_s,
        :name     => clean_name,
        :path     => path,
        :tags     => inferred_tags,
        :gdata    => gdata
      }
    end

  end
end
