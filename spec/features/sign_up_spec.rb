require 'spec_helper'

feature "User signs up", %Q{
  As a User
  I want to sign up
  so that I can be authenticated and use the site
} do

  # Acceptance Criteria:
  # * I must specify a valid email address
  # * I must specify and confirm a password
  # * If I fail either of the above, I receive an error message
  # * If I specify valid info, my account is registered and I am authenticated

  scenario 'specifying valid and required info' do
    visit root_path
    click_link 'Sign Up'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'user_password', with: 'password'
    fill_in 'Password Confirmation', with: 'password'

    click_button 'Sign Up'
    expect(page).to have_content("Success")
    expect(page).to have_content("Sign Out")
  end

  scenario 'specifying incomplete info'

  scenario 'password not confirmed'

end
