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

get '/employees' do
  erb :employee_list, locals: { employees: Employee.all }
end

post '/employees' do
  firstname = params['first_name']
  lastname = params['last_name']
  puts "create employee: #{firstname} #{lastname}"
  employee = Employee.create!(first_name:firstname, last_name:lastname)
  erb :employee_detail, :locals => { :employee => employee, :skills => Skill.all, :levels => SKILL_LEVELS  }
end

get '/employees/:id' do |id|
  erb :employee_detail, :locals => { :employee => Employee.find(id), :skills => Skill.all, :levels => SKILL_LEVELS }
end

post '/employees/:id' do |id|
  employee = Employee.find(id)
  skill_id = params['skill']
  level = params['level']
  
  employee.skills.create(Skill.find(skill_id), :level => level)
  
  erb :employee_detail, :locals => { :employee => Employee.find(id), :skills => Skill.all, :levels => SKILL_LEVELS }
end

get '/database' do
  respond_with :database, 'TODO'
end

helpers do  
  def abbreviate_skill_level(level) 
    SKILL_LEVELS[level]
  end
  
  def search(search)
    Employee.search(search)
  end
end

