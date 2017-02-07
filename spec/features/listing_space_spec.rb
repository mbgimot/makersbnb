require 'spec_helper'

feature 'user can list a space' do

  scenario 'a space has an owner' do
    user = User.create(name: 'name',
    email: 'test@test.com',
    password: 'password',
    password_conf: 'password')
    @space = user.spaces.create(name: 'name', description: 'description', price: 90.00, date_available: '2017-02-10 00:00:00')
    sign_in('test@test.com', 'password')
    expect(@space.user.name).to eq('name')
  end
  
  scenario 'user can fill in the listings form and create a space in the database' do
    visit '/'
    sign_up_true
    list_space
    expect( current_path ).to eq '/spaces/view'
    expect( page ).to have_content('House by the sea')
  end

  scenario 'user can add multiple listings' do
    visit '/'
    sign_up_true
    list_space
    list_another_space
    expect( current_path ).to eq '/spaces/view'
    expect( page ).to have_content('House by the sea')
    expect( page ).to have_content('Penthouse apartment')
  end
end
