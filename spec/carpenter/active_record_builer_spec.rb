require 'spec_helper'

describe Carpenter::ActiveRecordBuilder do
  class FakeBuilder
    include Carpenter::ActiveRecordBuilder

    def build
      @product
    end

    def set_fake_product(product)
      @product = product
    end
  end

  describe "#build!" do
    it "should save the product" do
      builder = FakeBuilder.new
      product = mock "active_record"
      builder.set_fake_product product
      product.should_receive :save!

      builder.build!
    end
  end
end
