class Skill
  include Neo4j::ActiveNode
  
  property :name, :type => String
  property :category
  property :synonyms
  property :description

  validates :name, :presence => true

  has_n(:employees).from(:HAS_SKILL)

end


