# encoding: utf-8
require_relative 'spec_helper.rb'

describe 'Skilda Webapp' do

  describe 'home page' do

    before(:each) { visit '/' }

    it 'should allow accessing the home page' do
      %w{Skilda Such Fähigkeiten Personen Projekte Datenbank}.each do |option|
        expect(page).to have_content(option)
      end
    end

    it 'should perform an empty search' do
      click_button('search-btn')
      expect(page).to have_content('Keine Treffer')
      puts page.body
    end

    it 'should perform a succesful search' do
      fill_in('search', :with => 'Java')
      click_button('search-btn')
      %w{Sebastian Matthias Marco}.each { |first_name|
        expect(page).to have_content(first_name)
      }
    end

    it 'should perform a unsuccesful search' do
      fill_in('search', :with => 'Jabba')
      click_button('search-btn')
      expect(page).to have_content('Keine Treffer')
    end

  end
end
