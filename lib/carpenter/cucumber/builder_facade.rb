require 'lib/carpenter/cucumber/row_mapper'

module Carpenter
  module Cucumber
    class BuilderFacade
      def build(table)
        table.hashes.each do |row|
          row.each_pair do |key, value|
            setter, argument = RowMapper.new(key, value).process
            @builder.send setter, argument
          end
        end

        @builder.build!
      end

      private

      def initialize(builder)
        @builder = builder
      end
    end
  end
end
