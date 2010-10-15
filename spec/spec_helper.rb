require "rubygems"
require "rspec"

$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), "..", "lib"))

require "doc_scan"

module SpecHelpers
  def scanner(extensions = ["rb"])
    path = File.join(File.dirname(__FILE__), "..", "lib")

    DocScan::Scanner.new(path) do |scanner|
      scanner.valid_extensions = extensions
    end
  end
end
