require 'spec_helper'

describe DocScan::Document do
  include SpecHelpers

  let(:documents) { scanner.run.map(&:to_hash) }

  it "should provide a checksum for each document" do
    documents.map { |h| h[:checksum] }.should include("4293898417")
    documents.map { |h| h[:checksum] }.should include("3757647072")
    documents.map { |h| h[:checksum] }.should include("928380254" )
  end

  it "should provide names for each document" do
    documents.map { |h| h[:name] }.should include("Doc Scan"    )
    documents.map { |h| h[:name] }.should include("Document"    )
    documents.map { |h| h[:name] }.should include("Name Cleaner")
    documents.map { |h| h[:name] }.should include("Scanner"     )
  end

  it "should provide paths for each document" do
    documents.map { |d| d[:path] }.each do |path|
      File.file?(path).should be_true
    end
  end

  it "should infer tags each document" do
    documents.map { |d| d[:tags] }.each do |tags|
      tags.should respond_to(:[])
    end
  end
end
