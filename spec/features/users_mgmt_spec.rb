require 'spec_helper'

feature 'User sign up' do
  scenario 'I can sign up as a new user' do
    expect{ sign_up }.to change(User, :count).by 1
    expect(page).to have_content('Welcome, testuser1')
    expect(User.first.email).to eq('testuser1')
  end

  scenario 'will not allow user to log in' do
    expect{ wrong_sign_up }.to change(User, :count).by 0
    # expect(page).to have_content("You've entered your password wrong")
  end
end
