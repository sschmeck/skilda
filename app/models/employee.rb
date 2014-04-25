class Employee
  include Neo4j::ActiveNode

  property :first_name
  property :last_name

  validates :last_name, :presence => true

  has_n('skills', :HAS_SKILL)

  def name
    "#{first_name} #{last_name}"
  end

  def to_s
    "#{last_name}, #{first_name}"
  end
  
  def self.search(search)
    if search.length == 0
      []
    else 
       r = Skill.neo4j_session._query("MATCH (e:Employee)-[r:HAS_SKILL]-(s:Skill) WHERE s.name =~ '(?i).*#{search}.*' RETURN DISTINCT ID(e);")
       Skill.neo4j_session.search_result_to_enumerable(r).to_a
    end
  end

end
