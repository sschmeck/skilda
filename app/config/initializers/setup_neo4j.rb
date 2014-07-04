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
db_config_file = File.join(File.dirname(__FILE__), '..', 'neo4j.yml')
db_config = YAML.load(File.read(db_config_file))
begin
  Neo4j::Session.open(db_config['session_type'].to_sym,
                      "http://#{db_config['host']}:#{db_config['port']}")
rescue
  puts "Could not establish connection to neo4j with configuration #{db_config.inspect}!"
  exit 1
end 
puts "Connected to neo4j (#{db_config.inspect})"

# load models
puts "Loading models .."
model_dir = File.join(File.dirname(__FILE__), '..', '..', 'models')
Dir.glob(File.join(model_dir, '*.rb')).each do |f|
 puts "  #{File.basename(f, File.extname(f)).camelize}"
 require f 
end
