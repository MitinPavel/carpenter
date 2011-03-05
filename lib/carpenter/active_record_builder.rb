module Carpenter
  module ActiveRecordBuilder
    def self.included(base)
      base.send :include, Carpenter::Builder
    end

    def build
      raise NotImplementedError
    end

    def build!
      product = build
      product.save!
    end
  end
end
