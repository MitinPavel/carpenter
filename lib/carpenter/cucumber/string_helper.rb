module Carpenter
  module Cucumber
    module StringHelper
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
      module_function :constantize
    end
  end
end
