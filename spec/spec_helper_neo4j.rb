require 'neo4j'

def create_session
  # TODO use Neo4j:Db class
  Neo4j::Session.open(:server_db, "http://localhost:7474")
end

def delete_db
  Neo4j::Session.current._query('MATCH (n) OPTIONAL MATCH (n)-[r]-() DELETE n,r')
end

RSpec.configure do |c|

  c.before(:suite) do
    Neo4j::Session.current.close if Neo4j::Session.current
    create_session
    delete_db
  end

  c.before(:each) do
    Neo4j::Session._listeners.clear
    create_session unless Neo4j::Session.current
    delete_db
  end

end
