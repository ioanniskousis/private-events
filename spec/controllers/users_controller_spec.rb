require 'rails_helper'

RSpec.describe 'Users', type: :feature do
  before :each do
    User.create(name: 'Patric')
    visit '/sessions/new'
    fill_in 'name', with: 'Patric'
    click_button 'Login'
  end

  describe 'GET /users' do
    it 'finds text Users' do
      visit users_path
      expect(page).to have_content('Users')
    end
  end

  describe 'GET /user/1' do
    it 'finds the name of the first user \'Patric\' ' do
      visit user_path(1)
      expect(page).to have_content('Patric')
    end

    it 'finds the text \'Events To Attend\' ' do
      visit user_path(1)
      expect(page).to have_content('Events To Attend')
    end

    it 'finds the text \'Attended Events\' ' do
      visit user_path(1)
      expect(page).to have_content('Attended Events')
    end

    it 'finds a link to events/new' do
      visit user_path(1)
      expect(page).to have_link('New Event', href: '/events/new')
    end

    it 'destroys user' do
      visit user_path(1)
      click_link 'Destroy'
      sleep(1)
      expect(page).to have_content('User was successfully destroyed')
    end
  end
end
