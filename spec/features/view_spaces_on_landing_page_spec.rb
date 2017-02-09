require 'spec_helper'

feature 'user can view spaces without logging in' do
  scenario 'user can see a list of spaces in chronological order on the landing page' do
    create_spaces
    visit '/'
    expect( page ).to have_content('House by the sea')
    expect( page ).to have_content('Penthouse apartment')
    expect('Penthouse apartment').to appear_before('House by the sea')
  end
end
