require_relative 'skill_category'

class Skill
  include Neo4j::ActiveNode

  property :name, type: String
  property :synonyms
  property :description

  validates :name, presence: true

  has_many :in, :persons, type: 'HAS_SKILL'
  has_many :out, :categories, model_class: SkillCategory, type: 'HAS_SKILL'
end