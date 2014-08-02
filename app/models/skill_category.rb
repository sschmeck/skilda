class SkillCategory
  include Neo4j::ActiveNode

  property :name, :type => String

  validates :name, :presence => true

  has_n(:skills).from(:IS_A)
end
