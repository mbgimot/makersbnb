require 'spec_helper'

feature 'user can see detailed space' do

  before(:each) do
    sign_up_true
    visit('/spaces/view')
    list_space_one
  end

  scenario "has a unique page for each listing" do
    click_button('Details')
    expect(page).to have_content('House by the sea')
  end
end
