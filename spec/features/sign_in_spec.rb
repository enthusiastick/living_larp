require 'spec_helper'

feature "User signs in", %Q{
  As a User
  I want to sign in
  so that I can be authenticated and use the site
} do

  # Acceptance Criteria:
  # * If I specify a valid, previously registered email and password, I am authenticated
  # * If I specify an invalid email or password, I remain unauthenticated
  # * If I am already signed in, I can't sign in again

  scenario 'existing user specifies valid info' do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Sign In'
    expect(page).to have_content('Welcome')
    expect(page).to have_content('Sign Out')
  end

  scenario 'an unregistered user signs in'

  scenario 'an authenticated user can\'t sign in again'

end
