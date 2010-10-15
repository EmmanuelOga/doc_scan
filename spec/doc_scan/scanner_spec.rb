require 'spec_helper'

describe DocScan::Scanner do
  include SpecHelpers

  it "returns instances of Document for all found files" do
    scanner.run.should_not be_empty
    scanner.run.each do |doc|
      doc.should be_an_instance_of(DocScan::Document)
    end
  end

  it "returns an empty array if no files match the provided extension" do
    scanner(["cobol"]).run.should be_empty
  end

end
