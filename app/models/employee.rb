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

end
