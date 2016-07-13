require('int_spec_helper')

describe('author path', {:type => :feature}) do
  it('shows a list of authors') do
    visit('/admin/authors')
    expect(page).to have_content("Author List")
  end

  it('show a new author added to the authors') do
    visit('/admin/authors')
    fill_in('name', :with => 'Test Test')
    click_button('Submit')
    expect(page).to have_content('Test Test')
  end

  it('will update an existing user ') do
    visit('/admin/authors')
    fill_in('name', :with => 'Test Test')
    click_button('Submit')
    click_button('Edit')
    expect(page).to have_content('Edit ')
    fill_in('name', :with => 'Other Test')
    click_button('Submit')
    expect(page).to have_content('Other Test')
  end

  it('remove an author from the list') do
    visit('/admin/authors')
    fill_in('name', :with => 'Test Test')
    click_button('Submit')
    expect(page).to have_content('Test Test')
    click_button('Delete')
    expect(page).to have_no_content('Test Test')
  end
end
