

feature 'allow tags to be added to urls' do
  scenario 'user adds a tag to a new link' do
    visit '/links/new'
    fill_in('Title', :with => 'Coding Love')
    fill_in('URL', :with => 'www.codinglove.com')
    fill_in('tags', :with => 'funny')
    click_button 'Create link'
    link = Link.first
    expect(link.tags.map(&:name)).to include 'funny'
  end


end
