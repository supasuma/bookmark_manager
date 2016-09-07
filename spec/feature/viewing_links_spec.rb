require 'spec_helper'


feature 'Viewing links' do

  scenario 'I can see existing links on the links page' do
    Link.create(url: 'http://www.makersacademy.com', title: 'Makers Academy')
    visit '/links'
    expect(page.status_code).to eq 200
    within 'ul#links' do #unordered list links
      expect(page).to have_content 'Makers Academy'
    end
  end

  before do
    Link.create(url: 'http://www.lovemeow.com/', title: 'LoveMeow', tags: [Tag.first_or_create(name: 'cats')])
    Link.create(url: 'http://cat-bounce.com/', title: 'Cat Bounce', tags: [Tag.first_or_create(name: 'cats')])
    Link.create(url: 'http://packdog.com/', title: 'Pack Dog', tags: [Tag.first_or_create(name: 'dogs')])
  end

  scenario 'user can filter links by tags' do
    visit '/tags/cats'
    expect(page.status_code).to eq 200
    within 'ul#links' do
      expect(page).to have_content 'LoveMeow'
      expect(page).to have_content 'Cat Bounce'
      expect(page).not_to have_content 'Pack Dog'
    end
  end
end
