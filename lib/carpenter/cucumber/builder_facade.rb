module Carpenter
  module Cucumber
    class BuilderFacade
      def build(table)
        table.hashes.each do |row|
          row.each_pair do |key, value|
            method, argument = RowParser.new.parse key, value
            @builder.send method, argument
          end
        end

        @builder.build!
      end

      private

      def initialize(builder)
        @builder = builder
      end

      class RowParser
        def parse(key, value)
          if value =~ /.+: .+/
            process_association key, value
          else
            [process_key(key), process_value(value)]
          end
        end

        private

        def process_key(key)
          "with_#{attributize key}"
        end

        def process_value(value)
          value
        end

        def process_association(key, value)
          clazz = constantize key
          raw_attr_name, attr_value = value.split /:\s+/
          attr_name = attributize raw_attr_name
          object = clazz.send "find_by_#{attr_name}", attr_value

          return [process_key(key), object] if object
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
end
