require 'spec_helper'

feature 'User sign up' do
  scenario 'I can sign up as a new user' do
    expect{ sign_up }.to change(User, :count).by 1
    expect(page).to have_content('Welcome, testuser1')
    expect(User.first.email).to eq('testuser1@gmail.com')
  end

  scenario 'will not allow user to log in' do
    expect{ wrong_sign_up }.to change(User, :count).by 0
    expect(current_path).to eq '/users'
    expect(page).to have_content("You've entered your password wrong")
  end

  scenario 'will not allow user to log in without an email address' do
    visit 'users/new'
    fill_in :email, with: nil
    click_button 'Sign up'
    expect(current_path).to eq '/users'
  end

  scenario 'will not allow user to log in with an invalid email address' do
    visit 'users/new'
    fill_in :email, with: 'alfie@com' 
    expect{click_button 'Sign up'}.to change(User, :count).by 0
  end
end
