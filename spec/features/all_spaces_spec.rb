require 'spec_helper'

feature 'user can view spaces listed' do
  scenario 'user can see a list of spaces in chronological order' do
    visit '/'
    sign_up_true
    list_space
    list_another_space
    expect( page ).to have_content('House by the sea')
    expect( page ).to have_content('Penthouse apartment')
    expect('Penthouse apartment').to appear_before('House by the sea')
  end
end
