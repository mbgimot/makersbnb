require 'spec_helper'

feature 'user can list a space' do

  before(:each) do
    user = User.create(name: 'name',
    email: 'test@test.com',
    password: 'password',
    password_conf: 'password')

    @space = user.spaces.create(name: 'name', description: 'description', price: 90.00, date_available: '2017-02-10 00:00:00')
    sign_in('test@test.com', 'password')
  end

  scenario 'a space has an owner' do
    expect(@space.user.name).to eq('name')
  end
  scenario 'user can fill in the listings form and create a space in the database' do
    visit '/spaces/view'

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
