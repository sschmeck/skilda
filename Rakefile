require 'rake'
require 'neo4j/tasks/neo4j_server.rake'

unless ENV['RACK_ENV'] == 'production'
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new do |task|
    task.rspec_opts = ['--color', '-r ./spec/spec_helper.rb']
    task.pattern    = 'spec/**/*_spec.rb'
  end
end

namespace :neo4j do
  desc 'Executes db/seed.cypher'
  task :seed do
    require_relative 'app/neo4j/db'
    Neo4j::Db.execute_file(File.join(File.dirname(__FILE__), 'db', 'seed.cypher'))
  end
end
