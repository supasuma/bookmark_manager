def sign_up
  visit '/users/new'
  fill_in('email', :with => 'summerisawesome@gmail.com')
  fill_in('password', :with => 'murtzrocks')
  click_button 'Sign up'
end 
