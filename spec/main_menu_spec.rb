require 'rails_helper'

RSpec.describe 'Users', type: :feature do
  before :each do
    User.create(name: 'Patric')
    visit '/sessions/new'
    fill_in 'name', with: 'Patric'
    click_button 'Login'
  end

  describe 'actions on the application\'s top bar' do
    it 'finds the link \'New Event\' on the top bar' do
      expect(page).to have_link('New Event', href: '/events/new')
    end

    it 'opens page /users which contains text \'User Name\', \'Events Created\', \'Events To Attend\', \'Events Attended\' ' do
      click_link('Users', href: '/users')
      expect(page).to have_content('User Name')
      expect(page).to have_content('Events Created')
      expect(page).to have_content('Events To Attend')
      expect(page).to have_content('Events Attended')
    end

    it 'opens page /events which contains text \'Upcoming Events\', \'Past Events\', \'Description\', \'Location\' ' do
      click_link('Events', href: '/events')
      expect(page).to have_content('Upcoming Events')
      expect(page).to have_content('Past Events')
      expect(page).to have_content('Description')
      expect(page).to have_content('Location')
    end

    it 'opens page events/new which contains text \'Event description\' and a submit button labeled \'Create Event\' ' do
      click_link('New Event', href: '/events/new')
      expect(page).to have_content('Event description')
      expect(page).to have_button('Create Event')
    end

    it 'there is a link labeled \'Patric\' ' do
      expect(page).to have_link('Patric', href: '/users/1')
    end

    it 'opens page user/1 which contains text \'About Patric\' ' do
      click_link('Patric', href: '/users/1')
      expect(page).to have_content('About Patric')
    end
  end
end
