require 'spec_helper'

describe Carpenter::Builder do
  describe ".contains" do
    let(:user_builder_class) { new_builder_class }
    let(:address) { mock :address }

    it "should add 'getter' for the passed part" do
      user_builder_class.new.should_not respond_to(:address)

      user_builder_class.contains :address

      builder = user_builder_class.new
      builder.instance_variable_set :@address, address
      builder.address.should == address
    end

    it "should add 'setter' for the passed part" do
      user_builder_class.new.should_not respond_to(:address=)

      user_builder_class.contains :address

      builder = user_builder_class.new
      builder.address = address
      builder.address.should == address
    end
  end
end
