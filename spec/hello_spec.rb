require 'spec_helper'

describe 'Hello application' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'says hello' do
    get '/'
    puts last_response.inspect
    last_response.should be_ok
    puts "body: #{last_response.body}"#.should =~ "Skilda"
  end

  it 'skills should be ok' do
    get '/skills'
    puts last_response.inspect
    last_response.should be_ok

    # could be factored out in a general tag matching method
    last_response.body[/(?<=<title>).*(?=<.title>)/].should == 'Skilda'

    %w{Skills Ruby Java}.each{|r| last_response.body.should =~ /#{r}/}
  end



end