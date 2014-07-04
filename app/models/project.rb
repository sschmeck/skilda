class Project

  include Neo4j::ActiveNode

  property :abvr
  property :description
  property :title

end