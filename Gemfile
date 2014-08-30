source 'https://rubygems.org'

# basic dependencies
gem 'sinatra'
gem 'sinatra-contrib'

gem 'neo4j', '>= 3.0.0.rc.2'

gem 'pdfkit'

group :test, :development do
  #gem 'tux'
  #gem 'shotgun'
  gem 'rspec'
  gem 'rack-test'
  gem 'capybara'
  gem 'coveralls'
end

group :production do
  # enable pdfkit on heroku
  gem 'wkhtmltopdf-heroku'
end