require_relative '../app/server'
require 'rack/test'
require 'capybara/rspec'

require 'coveralls'
Coveralls.wear!

ENV['RACK_ENV'] = 'test'

module RSpecMixin
  include Rack::Test::Methods
  def app() Sinatra::Application end
end

RSpec.configure { |c|
  c.include RSpecMixin
  c.include Capybara::DSL#, feature: true
  c.include Capybara::RSpecMatchers#, feature: true
}

Capybara.app = Sinatra::Application
