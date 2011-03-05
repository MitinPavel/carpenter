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

    it "should receive several arguments" do
      user_builder_class.contains :name, :email
    
      builder = user_builder_class.new

      builder.name = 'John'
      builder.name.should == 'John'
      builder.name = 'some@gmail.com'
      builder.name.should == 'some@gmail.com'
    end

    context "'with_' and 'for_' prefixed setters" do
      it "should add setters for the passed parts" do
        user_builder_class.contains :name
        builder = user_builder_class.new

        builder.with_name 'John'
        builder.name.should == 'John'

        builder.for_name 'Jill'
        builder.name.should == 'Jill'
      end

      it "should allow to build a chain of calls" do
        user_builder_class.contains :name, :email
        builder = user_builder_class.new
        builder.with_name('John').and.for_email('some@gmail.com')

        builder.email.should == 'some@gmail.com'
        builder.name.should == 'John'
      end
    end
  end
end
