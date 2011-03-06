require 'spec_helper'
require 'lib/carpenter/cucumber/builder_facade'
require 'cucumber/ast/table'

class User
  attr_accessor :email, :first_name

  def save!
  end
end

class UserBuilder
  include Carpenter::ActiveRecordBuilder
  contains :email, :first_name

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
      table = create_table <<-EOS
                             | Email           | First Name |
                             | some@gemail.com | John      |
                           EOS
      builder.should_receive(:with_email).with 'some@gemail.com'
      builder.should_receive(:with_first_name).with 'John'

      facade.build table
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
