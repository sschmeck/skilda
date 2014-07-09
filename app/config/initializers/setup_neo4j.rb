require 'neo4j'


# monkey patch gem
puts "Patching support for upper case relation names .."
Neo4j::ActiveNode::HasN::ClassMethods.module_eval do
    def has_n(name, rel_type = name)
      clazz = self
      module_eval(%Q{
              def #{name}()
                  dsl = _decl_rels_for('#{rel_type}'.to_sym)
                  Neo4j::ActiveNode::HasN::Nodes.new(self, dsl)
              end}, __FILE__, __LINE__)


      module_eval(%Q{
              def #{name}_rels
                  dsl = _decl_rels_for('#{rel_type}'.to_sym)
                  dsl.all_relationships(self)
              end}, __FILE__, __LINE__)

      instance_eval(%Q{
        def #{name}
          _decl_rels[:#{rel_type}].rel_type
        end}, __FILE__, __LINE__)
  
      _decl_rels[rel_type.to_sym] = Neo4j::ActiveNode::HasN::DeclRel.new(rel_type, false, clazz)
    end
end


# connect to database
begin
  neo4j_url = ENV['GRAPHENEDB_URL'] || 'http://localhost:7474'
 
  uri = URI.parse(neo4j_url)
 
  server_url = "http://#{uri.host}:#{uri.port}"
 
  Neo4j::Session.open(:server_db, 
                      server_url,
                      basic_auth: { username: uri.user, password: uri.password})
rescue => error
  puts "Could not establish connection to neo4j database: #{error}"
  exit 1
end 

# load models
puts "Loading models .."
model_dir = File.join(File.dirname(__FILE__), '..', '..', 'models')
Dir.glob(File.join(model_dir, '*.rb')).each do |f|
 puts "  #{File.basename(f, File.extname(f)).camelize}"
 require f 
end
