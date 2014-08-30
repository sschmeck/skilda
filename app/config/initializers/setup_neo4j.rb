require 'neo4j'
require_relative '../../neo4j/db'

# connect to database
Log.info 'Establish neo4j connection ..'
Neo4j::Db.establish_connection

# load models
Log.info 'Loading models ..'
model_dir = File.join(File.dirname(__FILE__), '..', '..', 'models')
Dir.glob(File.join(model_dir, '*.rb')).each { |f| require f }