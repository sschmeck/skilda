require 'neo4j'

module Neo4j
  class Db
    def self.establish_connection
      unless Neo4j::Session.current
        neo4j_url = ENV['GRAPHENEDB_URL'] || 'http://localhost:7474'
        uri = URI.parse(neo4j_url)
        server_url = "http://#{uri.host}:#{uri.port}"
 
        Neo4j::Session.open(:server_db, 
                            server_url,
                            basic_auth: { username: uri.user, password: uri.password})
      end
    rescue => error
      puts "Could not establish connection to neo4j database: #{error}"
      exit 1
    end

    def self.execute_file(file)
      establish_connection 
      File.open(file, 'r') { |f| f.read }.split(';').each do |stmt|
        Neo4j::Session.current._query(stmt) unless stmt.blank?
      end
    end
  end
end
