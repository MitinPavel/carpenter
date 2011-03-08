require 'lib/carpenter/cucumber/row_mapper'

module Carpenter
  module Cucumber
    class BuilderFacade
      def build(table)
        table.hashes.each do |row|
          row.each_pair do |key, value|
            process_row key, value
          end
        end

        @builder.build!
      end

      private

      def initialize(builder, association_resolver)
        @builder = builder
        @association_resolver = association_resolver
      end

      def process_row(key, value)
        row_mapper = RowMapper.new key, value, @association_resolver
        setter, argument = row_mapper.process
        @builder.send setter, argument
      end
    end
  end
end
