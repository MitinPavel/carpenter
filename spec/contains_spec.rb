require 'spec_helper'

describe Carpenter::Builder do
  describe ".contains" do
    let(:builder_class) { new_builder_class }
    let(:bar) { mock :bar }

    it "should add 'getter' for the passed part" do
      builder_class.new.should_not respond_to(:bar)

      builder_class.contains :bar

      builder = builder_class.new
      builder.instance_variable_set :@bar, bar
      builder.bar.should == bar
    end

    it "should add 'setter' for the passed part" do
      builder_class.new.should_not respond_to(:bar=)

      builder_class.contains :bar

      builder = builder_class.new
      builder.bar = bar
      builder.bar.should == bar
    end
  end
end
