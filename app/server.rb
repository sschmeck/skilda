require 'sinatra'
require 'sinatra/respond_with'

require_relative 'config/initializers/setup_neo4j'



# routes
get '/' do
  @search= params['search']
  @results = @search ? Skill.all.to_a : [] 
  puts "SKILL.all #{@results.inspect}"
  respond_with :index, 'TODO'
end

get '/skills' do
  erb :skill_list, locals: { skills: Skill.all }
end

get '/skills/:id' do |id|
  erb :skill_detail, :locals => { :skill => Skill.find(id) }
end

get '/employees' do
  erb :employee_list, locals: { employees: Employee.all }
end

get '/employees/:id' do |id|
  erb :employee_detail, :locals => { :employee => Employee.find(id) }
end

get '/database' do
  respond_with :database, 'TODO'
end

helpers do
  def abbreviate_skill_level(level) 
    case level
  	  when "Grundlagen"      then "B"
  	  when "Fortgeschritten" then "A"
  	  when "Professionell"   then "P"
  	  when "Expert"          then "E"
  	  else level
  	end
  end
end

