require_relative '../app/server'
require 'rspec'
require 'rack/test'

describe 'Skilda Webapp' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'should list skills' do
    get '/skills'
    last_response.should be_ok
    ['<title>Skilda</title>', '<b>Java<\/b>', '<b>Lua</b>', '<b>Neo4j</b>'].each do |s|
      last_response.body.should =~ Regexp.new(s)
    end
  end

  it 'should return Java on skill id 17 ' do
    get '/skills/17'
    last_response.should be_ok
    last_response.body.should =~ /<h2>Java<\/h2>/
  end

  it 'should list persons' do
    get '/persons'
    last_response.should be_ok
    ['<title>Skilda<\/title>', '<b>Sebastian Schmeck<\/b>', '<b>Matthias Baumgart<\/b>'].each do |s|
      last_response.body.should =~ Regexp.new(s)
    end
  end

  it 'should return Marco Dierenfeldt on person id 1' do
    get '/persons/1'
    last_response.should be_ok
    last_response.body.should =~ /<h1>Marco Dierenfeldt<\/h1>/
  end

end