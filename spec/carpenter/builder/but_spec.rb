require 'spec_helper'

describe Carpenter::Builder do
  describe "#but" do
    it "should raise NotImplementedError to force to override the method" do
      builder = new_builder
      expect { builder.but }.to raise_error(NotImplementedError)
    end
  end
end
