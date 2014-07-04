require 'bundler/setup'
require 'sinatra'
Sinatra::Application.environment = :test
Bundler.require :default, Sinatra::Application.environment
require 'rspec'
# require 'machinist'
# require 'machinist/mongoid'
# require File.dirname(__FILE__) + '/../config/boot'

RSpec.configure do |config|
  # config.before(:each) { Machinist.reset_before_test }
end

# Store.blueprint do
#   name        { Faker::Company.name }
#   email       { Faker::Internet.email }
#   password    { 'test123' }
#   description { Faker::Lorem.paragraph(1 + rand(3)) }
#   location    { Faker::Address.street_address }
# end