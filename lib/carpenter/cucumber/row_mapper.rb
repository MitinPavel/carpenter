require 'carpenter/cucumber/association_resolver'

module Carpenter
  module Cucumber
    class RowMapper
      def process
        association? ?  process_association : process_attribute
      end

      private

      def initialize(key, value, association_resolver)
        @key, @value = key, value
        @association_resolver = association_resolver
      end

      def association?
        class_exists? && attribute_and_value?
      end

      def class_exists?
        StringHelper.constantize @key
      rescue NameError
        false
      end

      def attribute_and_value?
        attribute_and_value_regexp = /.+: .+/
        @value =~ attribute_and_value_regexp
      end

      def process_attribute
        [process_key, process_value]
      end

      def process_key
        "with_#{attributize @key}"
      end

      def process_value
        @value
      end

      def process_association
        clazz, attr_name, attr_value = infer_association_data
        association = @association_resolver.find_or_create clazz, attr_name, attr_value
        return [process_key, association]
      end

      def infer_association_data
        clazz = StringHelper.constantize @key
        raw_attr_name, attr_value = @value.split /:\s+/
        attr_name = attributize raw_attr_name

        [clazz, attr_name, attr_value]
      end

      def attributize(string)
        string.gsub(/\s+/, '_').downcase
      end
    end
  end
end
