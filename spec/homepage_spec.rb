# encoding: utf-8
require_relative 'spec_helper.rb'

describe 'Skilda Webapp' do

  describe 'home page' do

    before(:each) { visit '/' }

    it "should allow accessing the home page" do
      get '/'
      expect(last_response).to be_ok
    end

    it 'should show navigation bar' do
      %w{Skilda Such Fähigkeiten Personen Projekte Datenbank}.each do |option|
        expect(page).to have_content(option)
      end
    end

    it 'should perform an empty search' do
      click_button('search-btn')
      expect(page).to have_content('Keine Treffer')
    end

    it 'should perform a succesful search' do
      s = Skill.create(name: 'Java')
      p1 = Person.create!(firstname: 'Marco', lastname: 'Reus')
      p2 = Person.create!(firstname: 'Thomas', lastname: 'Müller')
      p1.skills.create(s)
      p2.skills.create(s)

      fill_in('search', :with => 'Java')
      click_button('search-btn')

      result_list = all('//ul[@id="result-list"]/li')
      expect(result_list.size).to eq(2)
      expect(result_list.map{|li| li.text.split("\s").first}.sort).to eq(%w{Marco Thomas})
    end

    it 'should perform a unsuccesful search' do
      fill_in('search', :with => 'Jabba')
      click_button('search-btn')
      expect(page).to have_content('Keine Treffer')
    end

  end
end
