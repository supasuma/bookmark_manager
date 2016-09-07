feature 'Siging up' do
  scenario "when user signs up user count increases by one" do
    expect{ sign_up }.to change(User, :count).by 1
    expect(page).to have_content('Welcome, summerisawesome@gmail.com')
    expect(User.first.email).to eq('summerisawesome@gmail.com')
  end
end
