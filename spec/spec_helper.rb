require 'rubygems'
require 'bundler'
Bundler.setup

require 'rspec'
require 'grit_service'

RSpec.configure do |config|
  config.mock_with :rr
end

