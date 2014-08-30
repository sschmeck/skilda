class Project
  include Neo4j::ActiveNode

  property :abvr
  property :description
  property :title

  has_many :in, :persons, type: 'WORKED_FOR'
end