module Carpenter
  module Cucumber
    class RowMapper
      def process
        association? ?  process_association : process_attribute
      end

      private

      def initialize(key, value)
        @key, @value = key, value
      end

      def association?
        class_exists? && attribute_and_value?
      end

      def class_exists?
        constantize @key
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
        clazz = constantize @key
        raw_attr_name, attr_value = @value.split /:\s+/
        attr_name = attributize raw_attr_name
        object = clazz.send "find_by_#{attr_name}", attr_value

        return [process_key, object] if object
      end

      def attributize(string)
        string.gsub(/\s+/, '_').downcase
      end

      # http://api.rubyonrails.org/classes/ActiveSupport/Inflector.html
      def constantize(camel_cased_word)
        names = camel_cased_word.split('::')
        names.shift if names.empty? || names.first.empty?

        constant = Object
        names.each do |name|
          constant = constant.const_defined?(name) ? constant.const_get(name) : constant.const_missing(name)
        end
        constant
      end
    end
  end
end
