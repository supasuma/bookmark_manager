require 'spec_helper'

feature 'user login' do

  let!(:user) do
    User.create(email: 'flash_aaa@gmail.com',
    password: 'flash',
    password_confirmation: 'flash')
  end

  scenario 'sign in with correct credentials' do
    sign_in(email: user.email, password: 'flash')
    expect(page).to have_content("Welcome, #{user.email}")
  end

def sign_in(email:, password:)
  visit '/sessions/new'
  fill_in :email, with: email
  fill_in :password, with: password
  click_button 'Login'
end


end
