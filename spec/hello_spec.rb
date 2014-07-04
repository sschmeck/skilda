require_relative "../app/server"
require "rspec"
require "rack/test"

describe "Hello application" do
  include Rack::Test::Methods
  def app
    Sinatra::Application
  end

  it "says hello" do
    get "/"
    puts last_response.inspect
    last_response.should be_ok
    puts "body: #{last_response.body}"#.should =~ "Skilda"
  end

  it "" do
    get "/skills"
    puts last_response.inspect
    last_response.should be_ok

    puts "title: #{last_response.body.scan(/<title>.*</)}"
    %w{Skills Ruby Java}.each{|r| last_response.body.should =~ /#{r}/}
  end
end