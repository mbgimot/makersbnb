require 'spec_helper'

feature 'the user requests a space for one night and' do

  before(:each) do
    sign_up_true
    visit('/spaces/view')
    list_space
  end

  scenario "can request to rent someone else's property" do
    click_button('Logout')
    sign_up('Bob', 'bob@bobmail.com', 'password', 'password')
    sign_in('bob@bobmail.com', 'password')
    click_link('Details')
    fill_in(:date_requested, with:'2017-02-24')
    click_button('Request space')
    expect(page).to have_content('Your request has been sent to the owner')
  end

  scenario "cannot request to rent own property" do
    click_link('Details')
    fill_in(:date_requested, with:'2017-02-24')
    click_button('Request space')
    expect(page).to have_content('Cannot request to book own property')
  end

  scenario "cannot rent a date that is not available" do
    click_button('Logout')
    sign_up('Bob', 'bob@bobmail.com', 'password', 'password')
    sign_in('bob@bobmail.com', 'password')
    click_link('Details')
    fill_in(:date_requested, with:'2017-02-20')
    click_button('Request space')
    expect(page).to have_content('The selected date is not available')
  end

end
