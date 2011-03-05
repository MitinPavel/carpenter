require 'spec_helper'

describe Carpenter::ActiveRecordBuilder do
  class FakeActiveRecordBuilder
    include Carpenter::ActiveRecordBuilder
    contains :product

    def build
      @product
    end
  end

  describe "#build!" do
    it "should save the product" do
      product = mock "active_record"
      product.should_receive :save!
      builder = FakeActiveRecordBuilder.new.with_product product

      builder.build!
    end
  end
end
