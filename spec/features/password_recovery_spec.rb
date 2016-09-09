require 'spec_helper'

feature 'password recovery' do

  let!(:user) do
    User.create(email: 'flash_aaa@gmail.com',
    password: 'flash',
    password_confirmation: 'flash')
  end

  before do
    sign_in(email: user.email, password: 'flash')
    click_link 'sign out'
  end

  scenario 'get password recovery' do
    visit '/sessions/new'
    click_link 'Forgot Password'
    fill_in :email, with: user.email
    click_button 'Recover Password'
    expect(page).to have_content("You have been sent a recovery email - #{user.token}")
  end

  scenario 'reset password' do
    reset_password(user.email)
    visit '/sessions/reset/ResetToken'
    fill_in :new_password, with: 'NewPassword'
    fill_in :password_confirmation, with: 'NewPassword'
    click_button 'Reset Password'
    expect(current_path).to eq('/sessions/new')
    expect(page).to have_content("Your password has been reset")
  end
end
