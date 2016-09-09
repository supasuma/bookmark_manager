require 'spec_helper'

feature 'User sign up' do
  
  scenario 'I can sign up as a new user' do
    expect{ sign_up }.to change(User, :count).by 1
    expect(page).to have_content('Welcome, testuser1')
    expect(User.first.email).to eq('testuser1@gmail.com')
  end

  scenario 'will not allow user to sign up if passwords are mismatched' do
    expect{ wrong_sign_up }.to change(User, :count).by 0
    expect(current_path).to eq '/users'
    expect(page).to have_content("Password does not match the confirmation")
  end

  scenario 'will not allow user to sign up without an email address' do
    visit 'users/new'
    fill_in :email, with: nil
    click_button 'Sign up'
    expect(current_path).to eq '/users'
    expect(page).to have_content('Email must not be blank')
  end

  scenario 'will not allow user to sign up with an invalid email address' do
    visit 'users/new'
    fill_in :email, with: 'alfie@com'
    expect{ click_button 'Sign up' }.not_to change(User, :count)
    expect(current_path).to eq '/users'
    expect(page).to have_content('Email has an invalid format')
  end

  scenario 'will not allow user to sign up with an in use email address' do
    sign_up
    expect{ sign_up }.to change(User, :count).by 0
    expect(page).to have_content("Email is already taken")
  end



end
