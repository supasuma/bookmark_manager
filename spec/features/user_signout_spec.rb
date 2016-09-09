require 'spec_helper'

feature 'sign out' do

  let!(:user) do
    User.create(email: 'flash_aaa@gmail.com',
    password: 'flash',
    password_confirmation: 'flash')
  end

  before do
    sign_in(email: user.email, password: 'flash')
  end

  scenario 'sign out' do
    click_link 'sign out'
    expect(current_path).to eq '/links'
    expect(page).to have_content "See ya later sucker, #{user.email}"
    expect(page).not_to have_content "Welcome, #{user.email}"
  end
end
