require 'spec_helper'
require 'lib/carpenter/cucumber/builder_facade'
require 'cucumber/ast/table'

class User
  attr_accessor :email, :first_name

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
    User.new
  end
end

describe Carpenter::Cucumber::BuilderFacade do
  describe "#build" do
    let(:builder) { UserBuilder.new }
    let(:facade) { Carpenter::Cucumber::BuilderFacade.new builder }

    it "should build a product" do
      builder.should_receive :build!
      facade.build default_table
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
        Address.should_receive(:find_by_zipcode).and_return address
  
        facade.build user_table
      end

      it "shouldn't take inot account semicolons if there is no appropriate ruby class"
      it "should take into account namespaces"
    end

  end

  def default_table
    create_table <<-EOS
                   | Email           | First Name |
                   | john@gemail.com | John      |
                   | jill@gemail.com | Jill      |
                 EOS
  end

  def create_table(table_string)
    Cucumber::Ast::Table.parse table_string, nil, nil
  end
end
