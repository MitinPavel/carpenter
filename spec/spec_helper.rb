require 'rubygems'
require 'bundler/setup'

require 'carpenter'

RSpec.configure do |config|
end

def new_builder
  builder_class = Class.new
  builder_class.send :include, Carpenter::Builder
  builder_class.new
end
