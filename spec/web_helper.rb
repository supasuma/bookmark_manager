def sign_up
  visit '/users/new'
  expect(page.status_code).to eq(200)
  fill_in :email, with: 'testuser1@gmail.com'
  fill_in :password, with: 'my_secret_password'
  fill_in :password_confirmation, with: 'my_secret_password'
  click_button 'Sign up'
end

def wrong_sign_up
  visit '/users/new'
  expect(page.status_code).to eq(200)
  fill_in :email, with: 'testuser1@gmail.com'
  fill_in :password, with: 'my_secret_password'
  fill_in :password_confirmation, with: 'wrong_password'
  click_button 'Sign up'
end

def sign_in(email:, password:)
  visit '/sessions/new'
  fill_in :email, with: email
  fill_in :password, with: password
  click_button 'Login'
end
