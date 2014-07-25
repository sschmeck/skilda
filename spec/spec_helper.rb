require_relative '../app/server'
require 'rspec'
require 'rack/test'

require 'bundler/setup'
Sinatra::Application.environment = :test
Bundler.require :default, Sinatra::Application.environment