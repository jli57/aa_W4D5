require 'rails_helper'

feature 'the signup process' do
  scenario 'has a new user page' do
    visit new_user_url
    expect(page).to have_content('Sign Up')
    expect(page).to have_content('Username')
    expect(page).to have_content('Password')
  end

  feature 'signing up a user' do
    scenario 'shows username on the homepage after signup' do
      visit new_user_url
      fill_in 'Username', with: 'testtest'
      fill_in 'Password', with: 'password'
      click_button 'Create User'
      expect(page).to have_content('testtest')
    end
  end
end
