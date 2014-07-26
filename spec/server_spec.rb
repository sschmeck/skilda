# encoding: utf-8
require File.expand_path '../spec_helper.rb', __FILE__

describe 'Skilda Webapp' do

  it "should allow accessing the home page" do
    get '/'
    last_response.should be_ok
  end

  it "shows all skills" do
    get "/skills"
    last_response.should be_ok

    %w{Fähigkeiten Ruby Java}.each{|r| last_response.body.should =~ /#{r}/}
  end

#  it 'should return Java on skill id 17 ' do
#    get '/skills/17'
#    last_response.should be_ok
#    last_response.body.should =~ /<h2>Java<\/h2>/
#  end

  it 'should list persons' do
    get '/persons'
    last_response.should be_ok
    ['<title>Skilda<\/title>', '<b>Sebastian Schmeck<\/b>', '<b>Matthias Baumgart<\/b>'].each do |s|
      last_response.body.should =~ Regexp.new(s)
    end
  end

#  it 'should return Marco Dierenfeldt on person id 1' do
#    get '/persons/1'
#    last_response.should be_ok
#    last_response.body.should =~ /<h1>Marco Dierenfeldt<\/h1>/
#  end

end
