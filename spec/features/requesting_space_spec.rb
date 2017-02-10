require 'spec_helper'

feature 'the user requests a space for one night and' do

  before(:each) do
    sign_up_true
    visit('/spaces/view')
    list_space_one
  end

  scenario "can request to rent someone else's property" do
    change_user
    click_link('Details')
    find('#hidden_date', visible: false).set('24/02/2017')
    click_button('Request space')
    expect(page).to have_content('Your request has been sent to the owner')
  end

  scenario "cannot request to rent own property" do
    click_link('Details')
    find('#hidden_date', visible: false).set('24/02/2017')
    click_button('Request space')
    expect(page).to have_content('Cannot request to book own property')
  end
end
