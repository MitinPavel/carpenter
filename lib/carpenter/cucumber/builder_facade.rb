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
          [process_key(key), process_value(value)]
        end

        private

        def process_key(key)
          attribute = key.gsub(/\s+/, '_').downcase

          "with_#{attribute}"
        end

        def process_value(value)
          value
        end
      end
    end
  end
end
