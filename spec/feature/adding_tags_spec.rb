feature 'adding tags' do
  scenario 'user adds multiple tags to a link' do
    visit '/links/new'
    fill_in('Title', :with => 'Coding Love')
    fill_in('URL', :with => 'www.codinglove.com')
    fill_in('tags', :with => 'funny code')
    click_button 'Create link'
    link = Link.first
    expect(link.tags.map(&:name)).to include('funny', 'code')
  end
end
