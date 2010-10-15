require 'spec_helper'

describe DocScan::NameCleaner do
  subject { DocScan::NameCleaner.new(["ugly", "words"]) }

  it "works w/o parameters" do
    DocScan::NameCleaner.new.clean("some - string").should == "Some - String"
  end

  it "cleans ugly words from names" do
    subject.clean("THIS is an UGLY document!").should == "This Is An Document!"
  end

  it "cleans non sentence chars, normalizes dashes" do
    subject.clean("this_document   --- HAS 'many' _ugly dashes").should == "This Document - Has Many Dashes"
  end

  it "does not keep dashes at the end or the beginning of the document" do
    subject.clean("--Something--").should == "Something"
  end

  it "puts only one space where more than one is find" do
    subject.clean("one    very   crazy file     name").should == "One Very Crazy File Name"
  end
end

