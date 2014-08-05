class Person
  include Neo4j::ActiveNode

  property :firstname
  property :lastname
  property :year_of_birth

  validates :lastname, presence: true

  has_n('skills', :HAS_SKILL)
  has_n('projects', :WORKED_FOR)

  def name
    "#{firstname} #{lastname}"
  end

  def to_s
    "#{lastname}, #{firstname}"
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
