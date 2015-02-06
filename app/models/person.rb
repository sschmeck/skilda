class Person
  include Neo4j::ActiveNode

  property :firstname
  property :lastname
  property :year_of_birth

  validates :lastname, presence: true

  has_many :out, :skills, type: 'HAS_SKILL'
  has_many :out, :projects, type: 'WORKED_FOR'

  def name
    "#{firstname} #{lastname}"
  end

  def to_s
    "#{lastname}, #{firstname}"
  end

  def skills_by_categories
    skills.group_by(&:category)
  end

  def update_skills(skill_hash)
    # replaces all relations
    self.skills = []
    skill_hash.each do |element_id,level|
      skill = Skill.find_by!(neo_id: element_id.gsub('skill-', '').to_i)
      self.skills.create(skill, level: level)
    end
  end

  def self.search(search)
    if search.length == 0
      []
    else
      r = Skill.neo4j_session.query("MATCH (p:Person)-[r:HAS_SKILL]-(s:Skill) WHERE s.name =~ '(?i).*#{search}.*' RETURN DISTINCT ID(p);")
      r.map { |row| node_id = row.values[0]; Neo4j::Node.load(node_id) }
    end
  end

end