require 'spec_helper'

feature 'user can list a space' do
  scenario 'user can fill in the listings form and create a space in the database' do

    # log_in

    visit '/spaces'

    click_link('List a space')
    fill_in(:name, with: 'House by the sea')
    fill_in(:description, with: 'Lovely two-bed apartment overlooking the sea.')
    fill_in(:price, with: '35.00')
    select('2017-02-24', from: :available_date)
    click_button('Submit')

    expect( current_path ).to eq '/spaces'
    expect( page ).to have_content('House by the sea')

  end
end
