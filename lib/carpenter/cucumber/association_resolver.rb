require 'lib/carpenter/cucumber/string_helper'

module Carpenter
  module Cucumber
    class AssociationResolver
      def find_or_create(clazz, attr_name, attr_value)
        object = clazz.send "find_by_#{attr_name}", attr_value
        object ? object : create(clazz, attr_name, attr_value)
      end

      private

      def create(clazz, attr_name, attr_value)
        builder_class = StringHelper.constantize "#{clazz.name}Builder"
        builder = builder_class.new
        builder.send "with_#{attr_name}", attr_value #TODO respond_to?
        builder.build
      end
    end
  end
end
