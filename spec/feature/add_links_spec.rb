

feature 'add links' do
  scenario 'I can add a link to my bookmark manager' do
    visit '/links/new'
    expect(page.status_code).to eq 200
    fill_in('Title', :with => 'Google')
    fill_in('URL', :with => 'www.google.co.uk')
    click_button 'Create link'
    expect(current_path).to eq '/links'
    expect(page.status_code).to eq 200
    within 'ul#links' do
      expect(page).to have_content 'Google'
    end
  end
end
