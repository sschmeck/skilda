# require_relative '../app/server'
# require 'rspec'
# require 'rack/test'
#
# require 'bundler/setup'
# Sinatra::Application.environment = :test
# Bundler.require :default, Sinatra::Application.environment
require 'rack/test'

require 'coveralls'
Coveralls.wear!

require File.expand_path '../../app/server.rb', __FILE__

ENV['RACK_ENV'] = 'test'

module RSpecMixin
  include Rack::Test::Methods
  def app() Sinatra::Application end
end

RSpec.configure { |c| c.include RSpecMixin }
