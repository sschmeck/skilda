require 'sinatra'
require 'sinatra/respond_with'

require_relative 'config/initializers/setup_neo4j'

SKILL_LEVELS = { "Grundlagen" => "B", 
                 "Fortgeschritten" => "A",
                 "Professionell" => "P",
                 "Expert" => "E" }

# routes
get '/' do
  @search= params['search']
  @results = @search ? search(@search) : [] 
  puts "SKILL.all #{@results.inspect}"
  respond_with :index, 'TODO'
end

get '/skills' do
  erb :skill_list, locals: { skills: Skill.all }
end

get '/skills/:id' do |id|
  erb :skill_detail, :locals => { :skill => Skill.find(id) }
end

get '/persons' do
  erb :person_list, locals: { persons: Person.all }
end

post '/persons' do
  firstname = params['firstname']
  lastname = params['lastname']
  puts "create person: #{firstname} #{lastname}"
  person = Person.create!(firstname:firstname, lastname:lastname)
  erb :person_detail, :locals => { :person => person, :skills => Skill.all, :levels => SKILL_LEVELS  }
end

get '/persons/:id' do |id|
  erb :person_detail, :locals => { :person => Person.find(id), :skills => Skill.all, :levels => SKILL_LEVELS }
end

post '/persons/:id' do |id|
  person = Person.find(id)
  skill_id = params['skill']
  level = params['level']
  
  person.skills.create(Skill.find(skill_id), :level => level)
  
  erb :person_detail, :locals => { :person => Person.find(id), :skills => Skill.all, :levels => SKILL_LEVELS }
end

get '/database' do
  respond_with :database, 'TODO'
end

helpers do  
  def abbreviate_skill_level(level) 
    SKILL_LEVELS[level]
  end
  
  def search(search)
    Person.search(search)
  end
end

