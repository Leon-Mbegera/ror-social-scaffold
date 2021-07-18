require 'rails_helper'

feature 'user signing in and viewing timeline' do
  background do
    user = User.new(name: 'leon', email: 'leon@example.com', password: '123456')
    visit new_user_registration_path
    fill_in 'user_name', with: user.name
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    fill_in 'user_password_confirmation', with: user.password
    click_button 'Sign up'
  end

  scenario 'User view post page' do
    visit posts_path
    expect(page).to have_content('Recent posts')
  end

  scenario 'User send request page' do
    visit users_path
    click_button 'Send Request'
    redirect_to posts_path
    visit users_path
    expect(user_name).to have_content('Pending')
  end

  scenario 'User accept friendship invitation' do
    visit request_not_confirmed_path
    click_button 'Confirm'
    redirect_to friends_path
  end

  scenario 'User reject friendship invitation' do
    visit request_not_confirmed_path
    click_button 'Decline'
    redirect_to posts_path
  end


end
