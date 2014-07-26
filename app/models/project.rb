class Project
  include Neo4j::ActiveNode

  property :abvr
  property :description
  property :title

  has_n('persons').from(:WORKED_FOR)
end
