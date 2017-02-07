require 'spec_helper'

feature 'user can list a space' do
  scenario 'user can fill in the listings form and create a space in the database' do
    visit '/'
    sign_up_true
    click_link('List a space')
    fill_in(:name, with: 'House by the sea')
    fill_in(:description, with: 'Lovely two-bed apartment overlooking the sea.')
    fill_in(:price, with: '35.00')
    fill_in(:date_available, with:'2017-02-24')
    click_button('List space')

    expect( current_path ).to eq '/spaces/view'
    expect( page ).to have_content('House by the sea')

  end
end
