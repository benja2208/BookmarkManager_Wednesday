feature 'Adding tags' do

  scenario 'I can add multiple tags to a new link' do
    visit '/links/new'
    fill_in 'url', with: 'http://www.makersacademy.com'
    fill_in 'title', with: 'Makers Academy'
    fill_in 'tag', with: 'Education, ruby'
    click_button 'Create link'
    link = Link.first
    expect(link.tags.map(&:name)).to include('Education', 'Ruby')
  end
end
