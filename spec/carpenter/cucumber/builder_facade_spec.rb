require 'spec_helper'
require 'lib/carpenter/cucumber/builder_facade'
require 'cucumber/ast/table'

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

    it "should set associations by passed atributes" do
      user_table = create_table <<-EOS
                                  | Address       |
                                  | Zipcode: 1234 |
                                EOS
      address = Address.new
      association_resolver.should_receive(:find_or_create).with(Address, 'zipcode', '1234').and_return address
      builder.should_receive(:with_address).with address
  
      facade.build user_table
    end

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

  def create_table(table_string)
    Cucumber::Ast::Table.parse table_string, nil, nil
  end
end
