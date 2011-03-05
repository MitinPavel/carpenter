require 'rubygems'
require 'bundler/setup'

require 'carpenter'

RSpec.configure do |config|
end

def new_builder_class
  builder_class = Class.new
  builder_class.send :include, Carpenter::Builder
end

def new_builder
  new_builder_class.new
end
