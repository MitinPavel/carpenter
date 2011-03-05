require 'spec_helper'

describe Carpenter::Builder do
  describe "#and" do
    it "should just return the object it is called on" do
      builder = new_builder
      builder.and.should be_equal(builder)
    end
  end
end
