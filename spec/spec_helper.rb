require 'rack/test'
require 'capybara/rspec'

require_relative 'spec_helper_neo4j'

require 'coveralls'
Coveralls.wear!

ENV['RACK_ENV'] = 'test'
require_relative '../app/server'

module RSpecMixin
  include Rack::Test::Methods

  def app()
    Sinatra::Application
  end
end

RSpec.configure do |c|
  c.include RSpecMixin
  c.include Capybara::DSL
  c.include Capybara::RSpecMatchers
end

Capybara.app = Sinatra::Application
