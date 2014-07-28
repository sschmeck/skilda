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
