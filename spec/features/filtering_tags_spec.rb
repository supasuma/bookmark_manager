require 'spec_helper'

feature 'filter tags' do
  scenario 'shows links of same tag' do
    visit 'links/new'
    fill_in 'url',   with: 'https://en.wikipedia.org/wiki/Bubbles'
    fill_in 'title', with: "Michael Jackson's monkey"
    fill_in 'tags', with: 'bubbles'
    visit '/tags/bubbles'
    expect(page).to have_content "Michael Jackson's monkey"
  end
end
