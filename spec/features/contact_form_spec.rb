require 'spec_helper'

feature "User signs in", %Q{
  As a site visitor
  I want to contact the site's staff
  So that I can ask questions or make comments about the site
} do

  # Acceptance Criteria:
  # * I must specify a valid email address
  # * I must specify a subject
  # * I must specify a description
  # * I must specify a first name
  # * I must specify a last name

  scenario "with all correct info" do
    ActionMailer::Base.deliveries = []
    visit new_contact_path
    fill_in 'First', with: 'Clara'
    fill_in 'Last', with: 'Oswald'
    fill_in 'Email', with: 'foo@example.com'
    fill_in 'Subject', with: 'time and space'
    fill_in 'Message', with: 'help i am trapped in the time vortex'
    click_button 'Send Message'

    expect(ActionMailer::Base.deliveries.size).to eq(1)
    last_email = ActionMailer::Base.deliveries.last
    expect(last_email).to have_subject(/time and space/)
    expect(last_email).to deliver_to('contact@example.com')
    expect(last_email).to have_body_text(/help i am trapped in the time vortex/)
  end
end
