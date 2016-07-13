require('int_spec_helper')

describe('book path', {:type => :feature}) do
  it('shows a list of books') do
    visit('/admin/books')
    expect(page).to have_content("Book List")
  end

  it('show a new book added to the books') do
    visit('/admin/books')
    fill_in('name', :with => 'Test Test')
    click_button('Submit')
    expect(page).to have_content('Test Test')
  end

  it('will update an existing user ') do
    visit('/admin/books')
    fill_in('name', :with => 'Test Test')
    click_button('Submit')
    click_button('Edit')
    expect(page).to have_content('Edit ')
    fill_in('name', :with => 'Other Test')
    click_button('Submit')
    expect(page).to have_content('Other Test')
  end

  it('remove an book from the list') do
    visit('/admin/books')
    fill_in('name', :with => 'Test Test')
    click_button('Submit')
    expect(page).to have_content('Test Test')
    click_button('Delete')
    expect(page).to have_no_content('Test Test')
  end
end
