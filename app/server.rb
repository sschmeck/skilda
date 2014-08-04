require 'sinatra'
require 'sinatra/respond_with'

require_relative 'config/initializers/setup_neo4j'

require 'wkhtmltopdf-heroku' if production?
require_relative 'business/pdf_creator'

helpers PdfCreator

SKILL_LEVELS = { 'Grundlagen' => 'G', 
                 'Fortgeschritten' => 'F',
                 'Professionell' => 'P',
                 'Experte' => 'E' }

helpers do  
  def abbreviate_skill_level(level) 
    SKILL_LEVELS[level]
  end
  
  def search(search)
    Person.search(search)
  end
end

# routes
get '/' do
  @search = params['search']
  @results = @search ? search(@search) : [] 

  erb :index
end

get '/skills' do
  erb :'skill/list', locals: { skills: Skill.all, categories: SkillCategory.all }
end

post '/skills' do
  skill = Skill.create!(params.slice('name', 'description')) 
  skill.categories.create(SkillCategory.find(params['category']))
  
  redirect "/skills/#{skill.id}"
end

get '/skills/:id' do |id|
  erb :'skill/detail', locals: { skill: Skill.find(id) }
end


get '/persons' do
  erb :'person/list', locals: { persons: Person.all }
end

post '/persons' do
  person = Person.create!(params.slice('firstname', 'lastname'))

  redirect "/persons/#{person.id}"
end

get '/persons/:id' do |id|
  erb :'person/detail', locals: { person: Person.find(id), skills: Skill.all, levels: SKILL_LEVELS }
end

get '/persons/:id/pdf' do |id|
  content_type 'application/pdf'
  attachment 'skill_profile.pdf'

  create_person(Person.find(id))
end

post '/persons/:id' do |id|
  person = Person.find(id)
  skill_id = params['skill']
  level = params['level']
  person.skills.create(Skill.find(skill_id), level: level)
  
  redirect "/persons/#{id}"
end

delete '/person/:id' do |id|
  Person.find(id).destroy
  
  redirect '/persons'
end

get '/skillcategories' do
  erb :'skillcategory/list', locals: { skillcategories: SkillCategory.all }
end

get '/skillcategories/:id' do |id|
  erb :'skillcategory/detail', locals: { skillcategory: SkillCategory.find(id) }
end


get '/database' do
  erb :database
end


get '/projects' do
  erb :'project/list', locals: { projects: Project.all }
end

get '/projects/:id' do |id|
  erb :'project/detail', locals: { project: Project.find(id) }
end

post '/projects' do
  abvr = params['abvr']
  description = params['description']
  title = params['title']
  Project.create!(abvr: abvr, description: description, title: title)

  erb :index
end
