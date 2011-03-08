require 'spec_helper'
require 'lib/carpenter/cucumber/association_resolver'

describe Carpenter::Cucumber::AssociationResolver do
  let(:resolver) { Carpenter::Cucumber::AssociationResolver.new }

  describe "#find_or_create" do
    it "should return found activerecord object" do
      user = User.new
      User.stub(:find_by_first_name).with('Jill').and_return user

      resolver.find_or_create(User, 'first_name', 'Jill').should == user
    end

    it "should create an object if it isn created yet" do
      User.stub(:find_by_first_name).with('Jill').and_return nil

      user = resolver.find_or_create User, 'first_name', 'Jill'

      user.first_name.should == 'Jill'
    end
  end
end
