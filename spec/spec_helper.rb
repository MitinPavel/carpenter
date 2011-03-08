require 'rubygems'
require 'bundler/setup'

require 'carpenter'

RSpec.configure do |config|
end

Dir["spec/support/**/*.rb"].each {|f| require f}
