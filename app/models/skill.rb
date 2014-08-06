class Skill
  include Neo4j::ActiveNode

  property :name, type: String
  property :synonyms
  property :description

  validates :name, presence: true

  has_n('persons').from(:HAS_SKILL)
  has_n('categories', :IS_A)
end