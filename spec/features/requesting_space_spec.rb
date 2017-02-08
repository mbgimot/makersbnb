require 'spec_helper'

feature 'renter can request a space for one night' do

  before(:each) do
    sign_up_true
    visit('/spaces/view')
    list_space
  end

  scenario "cannot request to rent own property" do
    click_button('Details')
    fill_in(:date_requested, with:'2017-02-24')
    click_button('Request')
    expect(page).to have_content('Cannot request to book own property')
  end

  scenario "can request to rent someone else's property" do
    click_button('Logout')
    # LOG IN AS DIFFERENT USER...
    click_button('Details')
    fill_in(:date_requested, with:'2017-02-24')
    click_button('Request')
    expect(page).to have_content('Cannot request to book own property')
  end

  scenario "can't rent a date that is not available" do
    #...
  end

end
