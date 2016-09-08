def sign_up
  visit '/users/new'
  expect(page.status_code).to eq(200)
  fill_in :email, with: 'testuser1'
  fill_in :password, with: 'my_secret_password'
  fill_in :password_confirmation, with: 'my_secret_password'
  click_button 'Sign up'
end

def wrong_sign_up
  visit '/users/new'
  expect(page.status_code).to eq(200)
  fill_in :email, with: 'testuser1'
  fill_in :password, with: 'my_secret_password'
  fill_in :password_confirmation, with: 'wrong_password'
  click_button 'Sign up'
end
