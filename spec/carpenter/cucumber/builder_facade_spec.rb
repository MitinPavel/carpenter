require 'spec_helper'
require 'lib/carpenter/cucumber/builder_facade'
require 'cucumber/ast/table'

class User
  attr_accessor :email, :first_name, :address

  def save!
  end
end

class Address
  attr_accessor :zipcode
end

class UserBuilder
  include Carpenter::ActiveRecordBuilder
  contains :email, :first_name, :address

  def build
    @product = User.new
    @product.first_name = @first_name
    @product.address = @address

    @product
  end
end

describe Carpenter::Cucumber::BuilderFacade do
  describe "#build" do
    let(:builder) { UserBuilder.new }
    let(:association_resolver) { Carpenter::Cucumber::AssociationResolver.new }
    let(:facade) { Carpenter::Cucumber::BuilderFacade.new builder, association_resolver }

    it "should build a product" do
      table = create_table <<-EOS
                             | Email           | First Name |
                             | jill@gemail.com | Jill       |
                           EOS
      builder.should_receive :build!

      facade.build table
    end

    it "should set attributes passed through a cucumber table" do
      user_table = create_table <<-EOS
                                  | Email           | First Name |
                                  | some@gemail.com | John       |
                                EOS
      builder.should_receive(:with_email).with 'some@gemail.com'
      builder.should_receive(:with_first_name).with 'John'

      facade.build user_table
    end

    context "[association]" do
      it "should set associations found by passed atributes" do
        user_table = create_table <<-EOS
                                    | Address       |
                                    | Zipcode: 1234 |
                                  EOS
        address = Address.new
        Address.stub!(:find_by_zipcode).and_return address
        builder.should_receive(:with_address).with address
  
        facade.build user_table
      end

      #it "should create an object for an association if the object hasn't been created yet" do
      #  user_table = create_table <<-EOS
      #                              | Address       |
      #                              | Zipcode: 1234 |
      #                            EOS
      #  Address.stub!(:find_by_zipcode).and_return nil
      #  address_builder = AddressBuilder.new
      #  address_builder.should_receive(:with_zipcode).with '1234'
      #  address = Address.new
      #  address_builder.should_receive(:build!).and_return address
      #  builder.should_receive(:with_address).with address
  
      #  facade.build user_table
      #end

      it "should cope with an attribute if its value looks like an association value (contains a colon)" do
        user_table = create_table <<-EOS
                                    | First Name    |
                                    | Weird: name   |
                                  EOS
        builder.should_receive(:with_first_name).with "Weird: name"

        facade.build user_table
      end

      it "should take into account namespaces"

    end
  end

  def create_table(table_string)
    Cucumber::Ast::Table.parse table_string, nil, nil
  end
end
