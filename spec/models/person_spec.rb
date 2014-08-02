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
    person.skills.create(Skill.create(name: 'Jumping'))
    person.skills.create(Skill.create(name: 'Running'))

    expect(person.skills.map(&:name).sort).to eq(%w{Jumping Running})
  end

  it 'refers to projects' do
    person = Person.create(firstname: 'Manuel', lastname: 'Neuer')
    person.projects.create(Project.create(title: 'Deutscher Meister'))
    person.projects.create(Project.create(title: 'Weltmeister'))

    expect(person.projects.map(&:title).sort).to eq(['Deutscher Meister', 'Weltmeister'])
  end

  it 'supports search by skills' do
    p1 = Person.create(firstname: 'Manuel', lastname: 'Neuer')
    s1 = Skill.create(name: 'Jumping')
    p1.skills.create(s1)
    p2 = Person.create(firstname: 'Miroslav', lastname: 'Klose')
    p2.skills.create(Skill.create(name: 'Shooting'))
    p3 = Person.create(firstname: 'Rene', lastname: 'Adler')
    p3.skills.create(s1)
        
    results = Person.search('Jumping') 
    expect(results.map(&:firstname).sort).to eq(%w{Manuel Rene})
  end

end

