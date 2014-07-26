require 'rake'
require 'neography/tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new do |task|
  task.rspec_opts = ['--color', '-r ./spec/spec_helper.rb']
  task.pattern    = 'spec/**/*_spec.rb'
end

namespace :neo4j do
  desc 'Executes db/seed.cypher'
  task :seed do
    require_relative 'app/neo4j/db'
    Neo4j::Db.execute_file(File.join(File.dirname(__FILE__), 'db', 'seed.cypher'))
    #system('./neo4j/bin/neo4j-shell -file ./db/seed.cypher')
  end
end
