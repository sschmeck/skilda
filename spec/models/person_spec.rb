# encoding: utf-8
require_relative '../spec_helper.rb'

describe Person do

  it 'contains firstname and lastname' do
    person = Person.create(firstname: 'Manuel', lastname: 'Neuer')

    expect(person.firstname).to eq('Manuel')
    expect(person.lastname).to eq('Neuer')
    expect(person.name).to eq('Manuel Neuer')
    expect(person.to_s).to eq('Neuer, Manuel')
  end

  it 'refers to skills' do
    person = Person.create(firstname: 'Manuel', lastname: 'Neuer')
    person.skills << Skill.create(name: 'Jumping')
    person.skills << Skill.create(name: 'Running')

    expect(person.skills.map(&:name).sort).to eq(%w{Jumping Running})
  end

  it 'refers to skills with level attribute' do
    person = Person.create(firstname: 'Manuel', lastname: 'Neuer')
    person.skills.create(Skill.create(name: 'Jumping'), level: 'Experte')
    person.skills.create(Skill.create(name: 'Running'), level: 'Fortgeschritten')

    skills_with_level = person.skills_rels.map { |r| "#{r.end_node.name}-#{r[:level]}" }.sort
    expect(skills_with_level).to eq(%w{Jumping-Experte Running-Fortgeschritten})
  end

  it 'refers to projects' do
    person = Person.create(firstname: 'Manuel', lastname: 'Neuer')
    person.projects << Project.create(title: 'Deutscher Meister')
    person.projects << Project.create(title: 'Weltmeister')

    expect(person.projects.map(&:title).sort).to eq(['Deutscher Meister', 'Weltmeister'])
  end

  it 'supports search by skills' do
    p1 = Person.create(firstname: 'Manuel', lastname: 'Neuer')
    s1 = Skill.create(name: 'Jumping')
    p1.skills << s1
    p2 = Person.create(firstname: 'Miroslav', lastname: 'Klose')
    p2.skills << Skill.create(name: 'Shooting')
    p3 = Person.create(firstname: 'Rene', lastname: 'Adler')
    p3.skills << s1

    results = Person.search('Jumping')
    expect(results.map(&:firstname).sort).to eq(%w{Manuel Rene})
  end

  it 'updates all given skills' do
    p1 = Person.create(firstname: 'Manuel', lastname: 'Neuer')
    s1 = Skill.create(name: 'Jumping')
    p1.skills.create(s1, level: 'Fortgeschritten')
    s2 = Skill.create(name: 'Running')

    p1.update_skills("skill-#{s1.neo_id}" => 'Experte',
                     "skill-#{s2.neo_id}" => 'Fortgeschritten')

    skills_with_level = p1.skills_rels.map { |r| "#{r.end_node.name}-#{r[:level]}" }.sort
    expect(skills_with_level).to eq(%w{Jumping-Experte Running-Fortgeschritten})
  end

  it 'delivers skills by categories' do
    person = Person.create(firstname: 'Manuel', lastname: 'Neuer')
    person.skills << skill('Jumping', 'Sports')
    person.skills << skill('Running', 'Sports')
    person.skills << skill('Thinking', 'Mental')

    result = person.skills_by_categories
    expect(result.keys.map(&:name).sort).to eq(%w(Mental Sports))
    expect(result.find {|k,_| k.name == 'Sports'}.last.map(&:name).sort).to eq(%w(Jumping Running))
  end

  def skill(name, category)
    skill = Skill.create(name: name.to_s)
    category = SkillCategory.find_by(name: category.to_s) || SkillCategory.create(name: category.to_s)
    skill.category = category

    skill
  end
end
