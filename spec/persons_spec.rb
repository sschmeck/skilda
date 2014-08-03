# encoding: utf-8
require_relative 'spec_helper.rb'

describe 'Skilda Webapp' do

  describe 'persons' do

    it 'shows all persons by default' do
      Person.create(firstname: 'Marco', lastname: 'Reus')
      Person.create(firstname: 'Thomas', lastname: 'Müller')
      Person.create(firstname: 'Mats', lastname: 'Hummels')
      
      visit('/persons')
      person_list = all('//ul[@id="item-list"]/li')
      expect(person_list.size).to eq(3)
      expect(person_list.map{ |li| li.text.split("\s").first }.sort).to eq(%w{Marco Mats Thomas})
    end

    it 'create new persons' do
      visit('/persons')
      click_link('create-btn')
      fill_in('firstname', with: 'Mats')
      fill_in('lastname', with: 'Hummels')
      click_button('create')

      expect(page).to have_xpath('//h1', text: 'Mats Hummels')
      visit('/persons')
      expect(all('//ul[@id="item-list"]/li').size).to eq(1)
    end

    it 'updates existing persons'

    it 'deletes existing persons' do
      person = Person.create(firstname: 'Marco', lastname: 'Reus')
      visit('/persons')
      click_button("delete-#{person.id}")
      
      expect(page).to have_no_content('Reus')
    end

  end

end
