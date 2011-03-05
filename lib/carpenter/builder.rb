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
          define_setters part
        end
      end

      def define_setters(part_name)
        setter_name = "for_#{part_name}"
        define_method setter_name do |part|
          instance_variable_set "@#{part_name}", part
          self
        end
        alias_method "with_#{part_name}", setter_name
      end

    end
  end
end
