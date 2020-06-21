require 'rails_helper'

RSpec.describe 'Session Control', type: :feature do
  before :each do
    User.create(name: 'Patric')
  end

  it "Logs in and redirects to page events/index which contains the text 'Upcoming Events' " do
    visit '/sessions/new'
    fill_in 'name', with: 'Patric'
    click_button 'Login'
    expect(page).to have_content 'Upcoming Events'
  end

  it 'Logs in and expects application variable to have a value of User.first.id ' do
    visit '/sessions/new'
    fill_in 'name', with: 'Patric'
    click_button 'Login'
    expect(ApplicationController.session_user_id_for_testing).to eq(1)
  end

  it 'Tries to Log in with invalid user name and gets an error message' do
    visit '/sessions/new'
    fill_in 'name', with: 'foo-foo'
    click_button 'Login'
    sleep(1)
    expect(page).to have_content 'Wrong User Name'
  end

  it 'Logs out, redirects to login page and expects application variable to have a value of nil' do
    visit '/sessions/new'
    fill_in 'name', with: 'Patric'
    click_button 'Login'
    sleep(1)
    click_link 'Log Out'
    sleep(2)
    expect(page).to have_content 'User Name to Log In'
    expect(ApplicationController.session_user_id_for_testing).to eq(nil)
  end
end
