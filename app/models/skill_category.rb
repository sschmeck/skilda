class SkillCategory
  include Neo4j::ActiveNode

  property :name, type: String

  validates :name, presence: true

  has_many :in, :skills, type: 'IS_A'
end