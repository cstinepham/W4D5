require 'rails_helper'
require 'spec_helper'

feature 'the signup process' do
  background :each do
    visit.new_user_path
  end

  scenario 'has a new user page' do
    expect(page).to have_content("Sign Up")
  end

  feature 'signing up a user' do
    scenario 'shows username on the homepage after signup' do
      fill_in "Username", with: "Bob"
      fill_in "Password", with: "password"
      click_button "Sign Up"
      expect(page).to have_content("Bob")
      user = User.find_by(username: "Bob")
      expect(current_path).to eq(user_path(user))
    end
  end
end

feature 'logging in' do
  scenario 'shows username on the homepage after login' do
    fill_in "Username", with: "Bob"
    fill_in "Password", with: "password"
    click_button "Log In"
    expect(page).to have_content("Bob")
    user = User.find_by(username: "Bob")
    expect(current_path).to eq(user_path(user))
  end

end

feature 'logging out' do
  scenario 'begins with a logged out state' do
    
  end

  scenario 'doesn\'t show username on the homepage after logout'

end
