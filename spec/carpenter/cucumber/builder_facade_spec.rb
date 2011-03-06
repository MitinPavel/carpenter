require 'spec_helper'
require 'lib/carpenter/cucumber/builder_facade'
require 'cucumber/ast/table'

describe Carpenter::Cucumber::BuilderFacade do
  it "should just work" do
    user_table = create_table <<-EOS
      | Email  | Firstname |
      | email1 | John      |
      | email2 | Jill      |
    EOS

    user_table.hashes.each do |h|
      p h.inspect
    end
  end

  def create_table(table_string)
    Cucumber::Ast::Table.parse table_string, nil, nil
  end
end