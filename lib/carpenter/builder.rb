module Carpenter
  module Builder
    def self.included(base)
      base.extend ClassMethods
    end

    def and
      self
    end

    module ClassMethods
      def contains(*parts)
        parts.each do |part|
          attr_accessor part
        end
      end
    end
  end
end
