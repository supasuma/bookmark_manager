require 'spec_helper'

feature "Viewing links" do

  scenario "can view links on a page" do
    Link.create(url: 'http://www.bbc.co.uk', title: 'BBC')
    visit '/links'
    expect(page.status_code).to eq 200

    within 'ul#links' do
      expect(page).to have_content('BBC')
    end
  end

  before(:each) do
    Link.create(url: "https://en.wikipedia.org/wiki/Bubbles_(chimpanzee)", title: "Michael Jackson's monkey", tags: [Tag.first_or_create(name: 'bubbles')])
    Link.create(url: 'http://www.google.com', title: 'Google', tags: [Tag.first_or_create(name: 'search')])
  end

  scenario 'shows links of same tag' do
    visit '/tags/bubbles'
    expect(page.status_code).to eq 200
    within 'ul#links' do
      expect(page).not_to have_content('Google')
      expect(page).to have_content("Michael Jackson's monkey")
    end
  end
end
