module LoginHelper
  def login(user)
    user.confirmed_at = Time.now
    user.save
    visit '/'
    click_button 'sign_in_menu'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'sign_in_session'
  end
end
