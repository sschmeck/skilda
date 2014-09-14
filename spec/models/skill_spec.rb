# encoding: utf-8
require_relative '../spec_helper.rb'

describe Skill do

  it 'has properties name, synonyms and description' do
    skill = Skill.create(name: 'Ruby', synonyms: %w(CRuby JRuby), description: 'The most productive way to code.')

    expect(skill.name).to eq('Ruby')
    expect(skill.synonyms).to eq(%w(CRuby JRuby))
    expect(skill.description).to eq('The most productive way to code.')
  end

  it 'belongs to a skill category' do
    # categories should be master data
    category = SkillCategory.create(name: 'Programming')
    skill = Skill.create(name: 'Ruby')
    skill.category =  category

    expect(skill.category.name).to eq('Programming')
  end

  it 'refers to persons' do
    # categories should be master data
    person = Person.create(lastname: 'Matsumoto')
    skill = Skill.create(name: 'Ruby')
    skill.persons << person

    expect(skill.persons.map(&:lastname)).to eq(%w(Matsumoto))
  end

end