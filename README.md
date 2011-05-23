DocScan
=======

Utils to get infomration from documents in a folder (doc, pdf, djvu, etc.)

## Example

    # Rename a bunch of documents on the current directory with a better
    # name. The name will come from google data if an isbn is found in the
    # document, or a cleaned version of the original name (by removing
    # underscores, repeated spaces, etc.).

    require 'doc_scan'
    require 'fileutils'

    ds = DocScan::Scanner.new do |ds|
      ds.path = "."
      ds.valid_extensions = ["pdf", "djvu"]
    end

    ds.each do |doc|
      puts doc.clean_path
      FileUtils.mv doc.path, doc.clean_path if doc.path != doc.clean_path rescue nil
    end
