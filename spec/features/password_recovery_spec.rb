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
    allow(SecureRandom).to receive(:hex).and_return(1234)
  end

  scenario 'get password recovery' do
    visit '/sessions/new'
    click_link 'Forgot Password'
    fill_in :email, with: user.email
    click_button 'Recover Password'
    expect(page).to have_content("You have been sent a recovery email")
  end

  scenario 'reset password' do
    reset_password(user.email)
    visit "/sessions/reset/1234"
    #save_and_open_page
    fill_in :new_password, with: 'NewPassword'
    fill_in :password_confirmation, with: 'NewPassword'
    click_button 'Reset Password'
    expect(current_path).to eq('/sessions/new')
    expect(page).to have_content("Your password has been reset")
    sign_in(email: user.email, password: 'NewPassword')
    expect(page).to have_content("Welcome, #{user.email}")
  end

  scenario 'wrong token' do
    visit '/sessions/reset/WrongToken'
    fill_in :new_password, with: 'NewPassword'
    fill_in :password_confirmation, with: 'NewPassword'
    click_button 'Reset Password'
    expect(page).to have_content("Wrong Password Reset Link")
    expect(current_path).to eq('/sessions/recover')
  end


    scenario 'wrong password' do
      reset_password(user.email)
      visit "/sessions/reset/1234"
      fill_in :new_password, with: 'NewPassword'
      fill_in :password_confirmation, with: 'OldPassword'
      click_button 'Reset Password'
      expect(page).to have_content("Your Passwords do not match")
      expect(current_path).to eq('/sessions/reset')
    end

end
