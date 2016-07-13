require('int_spec_helper')

describe('patron path', {:type => :feature}) do
  it('shows user list and form') do
    visit('/')
    expect(page).to have_content('sign up')
  end

  it('shows a registration form') do
    visit('/signup')
    fill_in('name', :with => 'New Patron')
    click_button('Submit')
    expect(page).to have_content('New Patron')
  end
end
