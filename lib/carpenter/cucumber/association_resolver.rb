module Carpenter
  module Cucumber
    class AssociationResolver
      def find_or_create(clazz, attr_name, attr_value)
        object = clazz.send "find_by_#{attr_name}", attr_value
        object ? object : create(clazz, attr_name, attr_value)
      end

      private

      def create(clazz, attr_name, attr_value)
        user = User.new
        user.first_name = 'Jill'
        user
      end
    end
  end
end
