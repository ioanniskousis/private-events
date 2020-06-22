require 'rails_helper'

RSpec.describe 'Events Controller', type: :feature do
  before :each do
    User.create(name: 'Patric')
    Event.create(description: 'Olympic Games Show', location: 'FIFA Stadium', event_date: '2021-06-15', user_id: 1)
    visit '/sessions/new'
    fill_in 'name', with: 'Patric'
    click_button 'Login'
  end

  it 'creates a new event, redirects to events index and finds the created event\'s description' do
    visit '/events/new'
    fill_in 'event[description]', with: 'Patric\'s birthday party'
    fill_in 'event[location]', with: '9 Overhill Road, Dalwich SW4'
    fill_in 'event[event_date]', with: '2020-09-15'

    click_button 'Create Event'
    sleep(1)
    expect(page).to have_content 'Event was successfully created.'
    expect(page).to have_link('Patric\'s birthday party', href: '/events/2')
  end

  it 'getting an error trying to create a new event with invalid data' do
    visit '/events/new'
    click_button 'Create Event'
    sleep(1)
    expect(page).to have_content 'Description can\'t be blank'
  end

  it 'finds a link to the \'Olympic Games Show\' event in  the events index' do
    visit '/events'
    expect(page).to have_link('Olympic Games Show', href: '/events/1')
  end

  it 'opens \'Olympic Games Show\' event to edit' do
    visit '/events/1'
    click_link 'Edit'
    sleep(1)
    expect(page).to have_button('Update Event')
  end

  it 'updates Olympic Games Show event changing the event_date to 2021-06-20' do
    visit '/events/1/edit'
    fill_in 'event[event_date]', with: '2021-06-20'
    click_button 'Update Event'
    sleep(1)
    expect(page).to have_content('June 20, 2021')
  end

  it 'destroys Olympic Games Show event' do
    visit '/events/1'
    click_link 'Destroy'
    sleep(1)
    expect(page).to have_content('Event was successfully destroyed')
  end
end
